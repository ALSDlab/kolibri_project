import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCDataSource {
  // StreamController들을 클래스 레벨에서 관리하여 dispose에서 정리 가능하도록 함
  final Map<String, StreamController> _controllers = {};

  Future<MediaStream?> gettingUserMedia({
    required bool audioOnly,
    required RTCVideoRenderer localRenderer
  }) async {
    try {
      final Map<String, dynamic> mediaConstraints = {
        'video': audioOnly ? false : {'facingMode': 'user'},
        'audio': {
          'autoGainControl': false,
          'channelCount': 2,
          'echoCancellation': false,
          'latency': 0,
          'noiseSuppression': false,
          'sampleRate': 48000,
          'sampleSize': 16,
          'volume': 1.0
        },
      };

      MediaStream stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

      // Assign the stream to the provided localRenderer
      localRenderer.srcObject = stream;
      // 로컬 렌더러는 자기 자신의 소리를 듣지 않도록 음소거
      localRenderer.muted = true;

      return stream;
    } catch (e) {
      debugPrint('[WebRTCDataSource] getUserMedia Error: $e');
      return null;
    }
  }

  Future<void> turnOffMediaStream(
      MediaStream? stream,
      RTCVideoRenderer localRenderer
      ) async {
    if (stream != null) {
      // 모든 트랙 중지
      for (var track in stream.getTracks()) {
        track.enabled = false;
        await track.stop();
      }

      // 스트림 해제
      await stream.dispose();
    }

    // Clear the srcObject of the provided localRenderer
    localRenderer.srcObject = null;
  }

  Future<RTCPeerConnection> initializePeerConnection() async {
    Map<String, dynamic> configuration = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
        // TURN 서버가 필요한 경우 여기에 추가
        // {'urls': 'turn:YOUR_TURN_SERVER_IP:PORT', 'username': 'YOUR_USERNAME', 'credential': 'YOUR_PASSWORD'},
      ],
      'iceCandidatePoolSize': 10, // ICE candidate pool 크기 설정
    };

    return await createPeerConnection(configuration);
  }

  Future<void> addTrackToExistingPeerConnection(
      MediaStream stream,
      RTCPeerConnection peerConnection,
      ) async {
    for (var track in stream.getTracks()) {
      await peerConnection.addTrack(track, stream);
    }
  }

  // onTrackStream now takes the remoteRenderer to directly update it
  Stream<MediaStream> onTrackStream(
      RTCPeerConnection peerConnection,
      RTCVideoRenderer remoteRenderer
      ) {
    final controllerId = 'track_${peerConnection.hashCode}';

    // 기존 컨트롤러가 있으면 정리
    _controllers[controllerId]?.close();

    final controller = StreamController<MediaStream>.broadcast();
    _controllers[controllerId] = controller;

    peerConnection.onTrack = (RTCTrackEvent event) {
      debugPrint('[WebRTCDataSource] onTrack event received: ${event.streams.length} streams');

      if (event.streams.isNotEmpty) {
        final remoteStream = event.streams[0];

        // 원격 렌더러에 스트림 설정 - 이 부분이 원격 비디오 표시에 중요
        remoteRenderer.srcObject = remoteStream;

        if (!controller.isClosed) {
          controller.add(remoteStream);
        }
      } else {
        debugPrint('[WebRTCDataSource] onTrack event received but streams is empty.');
      }
    };

    return controller.stream;
  }

  Stream<RTCIceCandidate> onIceCandidateGeneratedStream(
      RTCPeerConnection peerConnection,
      ) {
    final controllerId = 'ice_${peerConnection.hashCode}';

    // 기존 컨트롤러가 있으면 정리
    _controllers[controllerId]?.close();

    final controller = StreamController<RTCIceCandidate>.broadcast();
    _controllers[controllerId] = controller;

    peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      debugPrint('[WebRTCDataSource] ICE candidate generated: ${candidate.candidate}');

      if (!controller.isClosed && candidate.candidate != null) {
        controller.add(candidate);
      }
    };

    return controller.stream;
  }

  Stream<RTCPeerConnectionState> onConnectionStateChangeStream(
      RTCPeerConnection peerConnection,
      ) {
    final controllerId = 'state_${peerConnection.hashCode}';

    // 기존 컨트롤러가 있으면 정리
    _controllers[controllerId]?.close();

    final controller = StreamController<RTCPeerConnectionState>.broadcast();
    _controllers[controllerId] = controller;

    peerConnection.onConnectionState = (state) {
      debugPrint('[WebRTCDataSource] Connection state changed: ${state.name}');

      if (!controller.isClosed) {
        controller.add(state);
      }
    };

    return controller.stream;
  }

  Future<RTCSessionDescription> createSdpOffer(
      RTCPeerConnection peerConnection,
      {bool audioOnly = false}
      ) async {
    final offerOptions = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': !audioOnly,
      }
    };

    final RTCSessionDescription description = await peerConnection.createOffer(offerOptions);
    return description;
  }

  Future<RTCSessionDescription> createSdpAnswer(
      RTCPeerConnection peerConnection,
      {bool audioOnly = false}
      ) async {
    final answerOptions = {
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': !audioOnly,
      }
    };

    final RTCSessionDescription description = await peerConnection.createAnswer(answerOptions);
    return description;
  }

  Future<void> setLocalDescription(
      RTCPeerConnection peerConnection,
      RTCSessionDescription description,
      ) async {
    await peerConnection.setLocalDescription(description);
    debugPrint('[WebRTCDataSource] Local description set: ${description.type}');
  }

  Future<void> setRemoteDescription(
      RTCPeerConnection peerConnection,
      RTCSessionDescription description,
      ) async {
    // 오디오 품질 개선을 위한 SDP 수정 (기존 참조 코드에서 가져옴)
    String modifiedSdp = description.sdp!;
    if (description.type == 'answer') {
      modifiedSdp = modifiedSdp.replaceFirst(
          'useinbandfec=1',
          'useinbandfec=1; stereo=1; maxaveragebitrate=510000'
      );
    }

    final modifiedDescription = RTCSessionDescription(modifiedSdp, description.type);
    await peerConnection.setRemoteDescription(modifiedDescription);
    debugPrint('[WebRTCDataSource] Remote description set: ${description.type}');
  }

  Future<void> appendIceCandidate(
      RTCIceCandidate candidate,
      RTCPeerConnection peerConnection,
      ) async {
    try {
      await peerConnection.addCandidate(candidate);
      debugPrint('[WebRTCDataSource] ICE candidate added successfully');
    } catch (e) {
      debugPrint('[WebRTCDataSource] Error adding ICE candidate: $e');
    }
  }

  Future<void> closePeerConnection(RTCPeerConnection peerConnection) async {
    // 해당 PeerConnection과 관련된 StreamController들 정리
    final controllersToRemove = <String>[];
    for (final entry in _controllers.entries) {
      if (entry.key.contains(peerConnection.hashCode.toString())) {
        entry.value.close();
        controllersToRemove.add(entry.key);
      }
    }

    for (final key in controllersToRemove) {
      _controllers.remove(key);
    }

    await peerConnection.close();
    debugPrint('[WebRTCDataSource] PeerConnection closed');
  }

  // ICE 재시작 메서드 추가
  Future<void> restartingIce(RTCPeerConnection peerConnection) async {
    try {
      await peerConnection.restartIce();
      debugPrint('[WebRTCDataSource] ICE restarted');
    } catch (e) {
      debugPrint('[WebRTCDataSource] Error restarting ICE: $e');
    }
  }

  // 트랙 교체 메서드 추가 (미디어 on/off 시 사용)
  Future<void> replacingTrack(
      RTCPeerConnection peerConnection,
      MediaStreamTrack newTrack,
      String trackKind,
      ) async {
    try {
      final senders = await peerConnection.getSenders();

      for (final sender in senders) {
        if (sender.track?.kind == trackKind) {
          await sender.replaceTrack(newTrack);
          debugPrint('[WebRTCDataSource] Track replaced: $trackKind');
          break;
        }
      }
    } catch (e) {
      debugPrint('[WebRTCDataSource] Error replacing track: $e');
    }
  }

  // Stream 리소스 정리를 위한 메서드
  void dispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }
    _controllers.clear();
    debugPrint('[WebRTCDataSource] Disposed all stream controllers');
  }
}
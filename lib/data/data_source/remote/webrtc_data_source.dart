import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCDataSource {
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  Future<void> initializeRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
  }

  Future<MediaStream?> getUserMedia({required bool audioOnly}) async {
    try {
      final Map<String, dynamic> mediaConstraints = {
        'audio': true, // Audio is generally always desired
        'video': audioOnly ? false : {'facingMode': 'user'},
      };
      MediaStream stream = await navigator.mediaDevices.getUserMedia(
        mediaConstraints,
      );
      localRenderer.srcObject = stream;
      return stream;
    } catch (e) {
      debugPrint('[WebRTCDataSource] getUserMedia Error: $e');
      return null;
    }
  }

  Future<void> turnOffMediaStream(MediaStream? stream) async {
    if (stream != null) {
      for (var track in stream.getTracks()) {
        await track.stop();
      }
      await stream.dispose();
    }
    if (localRenderer.srcObject == stream) {
      localRenderer.srcObject = null;
    }
  }

  Future<RTCPeerConnection> createPc() async {
    Map<String, dynamic> configuration = {
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ],
    };
    return createPeerConnection(configuration);
  }

  Future<void> addTrackToExistingPeerConnection(
    MediaStream stream,
    RTCPeerConnection peerConnection,
  ) async {
    stream.getTracks().forEach((track) {
      peerConnection.addTrack(track, stream);
    });
  }

  Stream<MediaStream> onTrackStream(RTCPeerConnection peerConnection) {
    final controller = StreamController<MediaStream>();
    peerConnection.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        remoteRenderer.srcObject = event.streams[0];
        controller.add(event.streams[0]);
      }
    };
    return controller.stream;
  }

  Stream<RTCIceCandidate> onIceCandidateGeneratedStream(
    RTCPeerConnection peerConnection,
  ) {
    final controller = StreamController<RTCIceCandidate>();
    peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      controller.add(candidate);
    };
    return controller.stream;
  }

  Stream<RTCPeerConnectionState> onConnectionStateChangeStream(
    RTCPeerConnection peerConnection,
  ) {
    final controller = StreamController<RTCPeerConnectionState>();
    peerConnection.onConnectionState = (RTCPeerConnectionState state) {
      controller.add(state);
    };
    return controller.stream;
  }

  void disposeAllRenderers() {
    localRenderer.dispose();
    remoteRenderer.dispose();
  }
}

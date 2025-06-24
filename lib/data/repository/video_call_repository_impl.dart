// video_call_repository_impl.dart

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/data_source/video_call_data_source.dart';
import 'package:kolibri_project/domain/repository/video_call_repository.dart';

import '../core/result.dart';
import '../dtos/gesture_data.dart';
import '../dtos/joystick_data.dart';

class VideoCallRepositoryImpl implements VideoCallRepository {
  final VideoCallDataSource _dataSource;
  late final String _roomId;
  String? _targetPeerId; // 타겟 피어 ID 추가

  VideoCallRepositoryImpl(this._dataSource);

  // DataSource의 socket에 접근할 수 있도록 getter 추가
  @override
  get socket => _dataSource.socket;

  // 타겟 피어 설정 메서드 추가
  @override
  void setTargetPeer(String peerId) {
    _targetPeerId = peerId;
  }

  @override
  Future<Result<void>> connect(String roomId) async {
    try {
      _roomId = roomId;
      // [수정] DataSource의 connect가 완료될 때까지 안정적으로 기다림
      await _dataSource.connect();

      // [수정] 불필요한 delay 및 isConnected 확인 로직 제거
      _dataSource.joinRoom(_roomId);

      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to connect to signaling server: $e');
    }
  }

  // 발신자 정보를 포함한 Offer 전송 메서드 추가
  @override
  Future<Result<void>> sendOfferWithCaller(
    RTCSessionDescription description,
    String targetPeerId,
  ) async {
    try {
      _dataSource.sendSignal('offer', {
        'roomId': _roomId,
        'sdp': description.toMap(),
        'targetPeerId': targetPeerId,
      });
      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to send offer with caller: $e');
    }
  }

  @override
  Future<Result<void>> sendAnswer(RTCSessionDescription description) async {
    try {
      _dataSource.sendSignal('answer', {
        'roomId': _roomId,
        'sdp': description.toMap(),
        'targetPeerId': _targetPeerId, // 타겟 지정
      });
      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to send answer: $e');
    }
  }

  @override
  Future<Result<void>> sendIceCandidate(RTCIceCandidate candidate) async {
    try {
      _dataSource.sendSignal('ice-candidate', {
        'roomId': _roomId,
        'candidate': candidate.toMap(),
        'targetPeerId': _targetPeerId, // 타겟 지정
      });
      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to send ice-candidate: $e');
    }
  }

  @override
  Future<Result<void>> sendJoystickData(JoystickData joystickData) async {
    try {
      _dataSource.sendSignal('signal', {
        'roomId': _roomId,
        'signalData': {'type': 'joystick', 'data': joystickData.toJson()},
        'targetPeerId': _targetPeerId, // 타겟 지정
      });
      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to send joystick data: $e');
    }
  }

  @override
  Future<Result<void>> sendGestureData(GestureData gestureData) async {
    try {
      _dataSource.sendSignal('signal', {
        'roomId': _roomId,
        'signalData': {'type': 'gesture', 'data': gestureData.toJson()},
        'targetPeerId': _targetPeerId, // 타겟 지정
      });
      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to send gesture data: $e');
    }
  }

  // 통화 거절 신호 전송 메서드 추가
  @override
  Future<Result<void>> sendCallRefusal(String targetPeerId) async {
    try {
      _dataSource.sendSignal('call-refusal', {
        'roomId': _roomId,
        'targetPeerId': targetPeerId,
      });
      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to send call refusal: $e');
    }
  }

  @override
  Future<Result<void>> sendHangUp(String targetPeerId) async {
    try {
      _dataSource.sendSignal('hang-up', {'targetPeerId': targetPeerId});
      return Result.success(null);
    } catch (e) {
      return Result.error('Failed to send hang-up: $e');
    }
  }

  // --- 데이터 수신 (Receive) ---
  @override
  Stream<(RTCSessionDescription, String)> get onOfferReceived =>
      _dataSource.onOffer.map((data) {
        final sdpData = data['sdp'] as Map<String, dynamic>;
        final fromId = data['from'] as String;

        // Answer나 ICE 전송 시 사용할 수 있도록 내부 targetPeerId 설정
        _targetPeerId = fromId;

        // ViewModel로 offer와 발신자 ID(fromId)를 함께 전달
        return (RTCSessionDescription(sdpData['sdp'], sdpData['type']), fromId);
      });

  @override
  Stream<RTCSessionDescription> get onAnswerReceived =>
      _dataSource.onAnswer.map((data) {
        final sdpData = data['sdp'] as Map<String, dynamic>;
        return RTCSessionDescription(sdpData['sdp'], sdpData['type']);
      });

  @override
  Stream<RTCIceCandidate> get onIceCandidateReceived =>
      _dataSource.onIceCandidate.map((data) {
        final candidateData = data['candidate'] as Map<String, dynamic>;
        return RTCIceCandidate(
          candidateData['candidate'],
          candidateData['sdpMid'],
          candidateData['sdpMLineIndex'],
        );
      });

  @override
  Stream<JoystickData> get onJoystickDataReceived => _dataSource.onSignal
      .where(
        (event) =>
            event['signalData'] != null &&
            event['signalData']['type'] == 'joystick',
      )
      .map((event) => JoystickData.fromJson(event['signalData']['data']));

  @override
  Stream<GestureData> get onGestureDataReceived => _dataSource.onSignal
      .where(
        (event) =>
            event['signalData'] != null &&
            event['signalData']['type'] == 'gesture',
      )
      .map((event) => GestureData.fromJson(event['signalData']['data']));

  @override
  Stream<void> get onPeerJoined => _dataSource.onPeerJoined.map((_) => null);

  @override
  Stream<void> get onDisconnected => _dataSource.onDisconnect;

  // 사용자 목록 업데이트 스트림 추가
  @override
  Stream<List<String>> get onUserListUpdate => _dataSource.onUserListUpdate;

  // 통화 거절 스트림 추가
  @override
  Stream<void> get onCallRefused => _dataSource.onCallRefused;

  @override
  Stream<void> get onHangUpReceived => _dataSource.onHangUpReceived;

  @override
  void dispose() {
    _dataSource.dispose();
  }
}

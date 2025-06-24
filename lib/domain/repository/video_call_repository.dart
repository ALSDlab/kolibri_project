import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../data/core/result.dart';
import '../../data/dtos/gesture_data.dart';
import '../../data/dtos/joystick_data.dart';

abstract class VideoCallRepository {
  get socket;

  Future<Result<void>> connect(String roomId);

  Future<Result<void>> sendOfferWithCaller(
    RTCSessionDescription description,
    String targetPeerId,
  ); // 추가
  Future<Result<void>> sendAnswer(RTCSessionDescription description);

  Future<Result<void>> sendIceCandidate(RTCIceCandidate candidate);

  Future<Result<void>> sendJoystickData(JoystickData joystickData);

  Future<Result<void>> sendGestureData(GestureData gestureData); // 추가
  Future<Result<void>> sendCallRefusal(String targetPeerId); // 추가
  Future<Result<void>> sendHangUp(String targetPeerId); // 추가

  void setTargetPeer(String peerId);

  Stream<(RTCSessionDescription, String)> get onOfferReceived;

  Stream<RTCSessionDescription> get onAnswerReceived;

  Stream<RTCIceCandidate> get onIceCandidateReceived;

  Stream<JoystickData> get onJoystickDataReceived;

  Stream<GestureData> get onGestureDataReceived; // 추가
  Stream<void> get onPeerJoined;

  Stream<void> get onDisconnected;

  Stream<List<String>> get onUserListUpdate;

  Stream<void> get onCallRefused; // 추가
  Stream<void> get onHangUpReceived; // 추가

  void dispose();
}

// domain/use_case/webrtc/signaling/hang_up_call_use_case.dart
import '../../../repository/webrtc_repository.dart';

class HangUpCallUseCase {
  final WebRTCRepository _repository;

  HangUpCallUseCase(this._repository);

  void call(String toUserId, String fromUserId) {
    _repository.hangUpCall(toUserId, fromUserId);
  }
}

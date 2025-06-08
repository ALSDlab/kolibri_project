// domain/use_case/webrtc/signaling/decline_incoming_call_use_case.dart
import '../../../repository/webrtc_repository.dart';

class DeclineIncomingCallUseCase {
  final WebRTCRepository _repository;

  DeclineIncomingCallUseCase(this._repository);

  void call(String toUserId) {
    _repository.declineIncomingCall(toUserId);
  }
}

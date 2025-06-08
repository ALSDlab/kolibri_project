// domain/use_case/webrtc/signaling/disconnect_signaling_use_case.dart
import '../../../repository/webrtc_repository.dart';

class DisconnectSignalingUseCase {
  final WebRTCRepository _repository;

  DisconnectSignalingUseCase(this._repository);

  void call() {
    _repository.disconnectSignaling();
  }
}

import '../../../repository/webrtc_repository.dart';

class DisconnectSignalingUseCase {
  final WebrtcRepository _repository;

  DisconnectSignalingUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call() => _repository.disconnectSignaling();
}

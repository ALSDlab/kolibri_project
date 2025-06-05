import '../../../repository/webrtc_repository.dart';

class InitializeRenderersUseCase {
  final WebrtcRepository _repository;

  InitializeRenderersUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call() => _repository.initializeRenderers();
}

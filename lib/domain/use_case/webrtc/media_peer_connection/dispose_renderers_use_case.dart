import '../../../repository/webrtc_repository.dart';

class DisposeRenderersUseCase {
  final WebrtcRepository _repository;

  DisposeRenderersUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  void call() => _repository.disposeRenderers();
}

import '../../../repository/webrtc_repository.dart';

class ListenForHangUpUseCase {
  final WebRTCRepository _webrtcRepository;

  ListenForHangUpUseCase(this._webrtcRepository);

  Stream<String> call() {
    return _webrtcRepository.getOnHangUpStream();
  }
}

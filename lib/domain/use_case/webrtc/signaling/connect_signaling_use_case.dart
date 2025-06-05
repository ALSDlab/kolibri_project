import '../../../../data/core/result.dart';
import '../../../repository/webrtc_repository.dart';

class ConnectSignalingUseCase {
  final WebrtcRepository _repository;

  ConnectSignalingUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<String>> call(String serverUrl) {
    return _repository.connectSignaling(serverUrl);
  }
}

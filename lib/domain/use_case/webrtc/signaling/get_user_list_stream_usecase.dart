import '../../../model/peer_user_model.dart';
import '../../../repository/webrtc_repository.dart';

class GetUserListStreamUseCase {
  final WebrtcRepository _repository;

  GetUserListStreamUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<List<PeerUserModel>> call() {
    return _repository.getOnlineUsersStream();
  }
}

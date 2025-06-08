// domain/use_case/webrtc/signaling/listen_for_user_list_use_case.dart
import 'dart:async';

import '../../../model/peer_user_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenForUserListUseCase {
  final WebRTCRepository _repository;

  ListenForUserListUseCase(this._repository);

  Stream<List<PeerUserModel>> call() {
    return _repository.listenForUserList();
  }
}

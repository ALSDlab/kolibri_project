// domain/use_case/webrtc/media_peer_connection/create_peer_connection_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class CreatePeerConnectionUseCase {
  final WebRTCRepository _repository;

  CreatePeerConnectionUseCase(this._repository);

  Future<Result<RTCPeerConnection>> call() async {
    return await _repository.createPeerConnection();
  }
}

// domain/use_case/webrtc/media_peer_connection/create_sdp_answer_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class CreateSdpAnswerUseCase {
  final WebRTCRepository _repository;

  CreateSdpAnswerUseCase(this._repository);

  Future<Result<RTCSessionDescription>> call(
    RTCPeerConnection peerConnection,
  ) async {
    try {
      final sdp = await _repository.createSdpAnswer(peerConnection);
      return Success(sdp);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

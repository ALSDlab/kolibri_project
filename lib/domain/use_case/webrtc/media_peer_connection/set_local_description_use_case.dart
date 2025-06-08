// domain/use_case/webrtc/media_peer_connection/set_local_description_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class SetLocalDescriptionUseCase {
  final WebRTCRepository _repository;

  SetLocalDescriptionUseCase(this._repository);

  Future<Result<void>> call(
    RTCPeerConnection peerConnection,
    RTCSessionDescription description,
  ) async {
    try {
      await _repository.settingLocalDescription(peerConnection, description);
      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

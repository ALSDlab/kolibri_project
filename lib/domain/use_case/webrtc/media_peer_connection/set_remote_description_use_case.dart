// domain/use_case/webrtc/media_peer_connection/set_remote_description_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class SetRemoteDescriptionUseCase {
  final WebRTCRepository _repository;

  SetRemoteDescriptionUseCase(this._repository);

  Future<Result<void>> call(
    RTCPeerConnection peerConnection,
    RTCSessionDescription description,
  ) async {
    try {
      await _repository.settingRemoteDescription(peerConnection, description);
      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

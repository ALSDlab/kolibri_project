// domain/use_case/webrtc/media_peer_connection/add_track_to_peer_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class AddTrackToPeerUseCase {
  final WebRTCRepository _repository;

  AddTrackToPeerUseCase(this._repository);

  Future<Result<void>> call(
    MediaStream stream,
    RTCPeerConnection peerConnection,
  ) async {
    try {
      await _repository.addTrackToPeerConnection(stream, peerConnection);
      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

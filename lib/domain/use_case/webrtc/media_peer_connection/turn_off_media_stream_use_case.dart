// domain/use_case/webrtc/media_peer_connection/turn_off_media_stream_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class TurnOffMediaStreamUseCase {
  final WebRTCRepository _repository;

  TurnOffMediaStreamUseCase(this._repository);

  Future<Result<void>> call(
    MediaStream? stream,
    RTCVideoRenderer localRenderer,
  ) async {
    try {
      await _repository.turnOffMediaStream(stream, localRenderer);
      return const Success(null);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

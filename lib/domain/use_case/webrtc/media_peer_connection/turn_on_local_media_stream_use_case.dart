// domain/use_case/webrtc/media_peer_connection/turn_on_local_media_stream_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class TurnOnLocalMediaStreamUseCase {
  final WebRTCRepository _repository;

  TurnOnLocalMediaStreamUseCase(this._repository);

  Future<Result<MediaStream>> call({
    required bool audioOnly,
    required RTCVideoRenderer localRenderer,
  }) async {
    return await _repository.turnOnLocalMediaStream(
      audioOnly: audioOnly,
      localRenderer: localRenderer,
    );
  }
}

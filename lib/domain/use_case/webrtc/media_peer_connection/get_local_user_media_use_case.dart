import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../../data/core/result.dart';
import '../../../repository/webrtc_repository.dart';

class GetLocalUserMediaUseCase {
  final WebrtcRepository _repository;

  GetLocalUserMediaUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<MediaStream?>> call({required bool audioOnly}) =>
      _repository.getLocalUserMedia(audioOnly: audioOnly);
}

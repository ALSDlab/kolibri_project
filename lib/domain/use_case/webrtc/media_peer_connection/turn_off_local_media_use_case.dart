import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class TurnOffLocalMediaUseCase {
  final WebrtcRepository _repository;

  TurnOffLocalMediaUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call(MediaStream? stream) =>
      _repository.turnOffLocalMedia(stream);
}

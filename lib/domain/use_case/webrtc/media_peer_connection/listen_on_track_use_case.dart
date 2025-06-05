import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class ListenOnTrackUseCase {
  final WebrtcRepository _repository;

  ListenOnTrackUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<MediaStream> call(RTCPeerConnection pc) =>
      _repository.getOnTrackStream(pc);
}

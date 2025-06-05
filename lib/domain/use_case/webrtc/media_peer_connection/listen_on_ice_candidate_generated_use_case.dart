import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class ListenOnIceCandidateGeneratedUseCase {
  final WebrtcRepository _repository;

  ListenOnIceCandidateGeneratedUseCase({
    required WebrtcRepository chatDataRepository,
  }) : _repository = chatDataRepository;

  Stream<RTCIceCandidate> call(RTCPeerConnection pc) =>
      _repository.getOnIceCandidateStream(pc);
}

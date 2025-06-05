import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class AddIceCandidateToPeerUseCase {
  final WebrtcRepository _repository;

  AddIceCandidateToPeerUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call(RTCIceCandidate candidate, RTCPeerConnection pc) =>
      _repository.addIceCandidateToPeer(candidate, pc);
}

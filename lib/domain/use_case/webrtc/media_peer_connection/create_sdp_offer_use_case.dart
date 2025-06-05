import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class CreateSdpOfferUseCase {
  final WebrtcRepository _repository;

  CreateSdpOfferUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<RTCSessionDescription> call(
    RTCPeerConnection pc, {
    required bool audioOnly,
  }) => _repository.createSdpOffer(pc, audioOnly: audioOnly);
}

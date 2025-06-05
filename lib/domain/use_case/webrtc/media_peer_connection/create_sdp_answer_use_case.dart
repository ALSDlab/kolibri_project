import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class CreateSdpAnswerUseCase {
  final WebrtcRepository _repository;

  CreateSdpAnswerUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<RTCSessionDescription> call(
    RTCPeerConnection pc, {
    required bool audioOnly,
  }) => _repository.createSdpAnswer(pc, audioOnly: audioOnly);
}

import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class SetRemoteDescriptionUseCase {
  final WebrtcRepository _repository;

  SetRemoteDescriptionUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call(RTCSessionDescription description, RTCPeerConnection pc) =>
      _repository.setRemoteDescription(description, pc);
}

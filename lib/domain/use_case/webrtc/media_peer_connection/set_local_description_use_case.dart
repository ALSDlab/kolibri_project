import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class SetLocalDescriptionUseCase {
  final WebrtcRepository _repository;

  SetLocalDescriptionUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call(RTCSessionDescription description, RTCPeerConnection pc) =>
      _repository.setLocalDescription(description, pc);
}

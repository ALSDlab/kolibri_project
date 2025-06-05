import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class DisposePeerConnectionUseCase {
  final WebrtcRepository _repository;

  DisposePeerConnectionUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call(RTCPeerConnection? pc) =>
      _repository.disposePeerConnection(pc);
}

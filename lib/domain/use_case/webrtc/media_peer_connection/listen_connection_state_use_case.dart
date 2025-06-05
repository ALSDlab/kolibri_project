import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class ListenConnectionStateUseCase {
  final WebrtcRepository _repository;

  ListenConnectionStateUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<RTCPeerConnectionState> call(RTCPeerConnection pc) =>
      _repository.getOnConnectionStateStream(pc);
}

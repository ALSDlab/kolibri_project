import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../repository/webrtc_repository.dart';

class AddTrackToPeerUseCase {
  final WebrtcRepository _repository;

  AddTrackToPeerUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<void> call(MediaStream stream, RTCPeerConnection pc) =>
      _repository.addTrackToPeer(stream, pc);
}

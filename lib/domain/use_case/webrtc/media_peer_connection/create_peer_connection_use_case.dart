import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../../../data/core/result.dart';
import '../../../repository/webrtc_repository.dart';

class CreatePeerConnectionUseCase {
  final WebrtcRepository _repository;

  CreatePeerConnectionUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<RTCPeerConnection>> call() =>
      _repository.createPeerConnection();
}

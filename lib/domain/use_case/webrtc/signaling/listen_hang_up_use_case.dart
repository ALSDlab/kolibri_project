import 'dart:async';

import '../../../repository/webrtc_repository.dart';

class ListenHangUpUseCase {
  final WebrtcRepository _repository;

  ListenHangUpUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<String> call() => _repository.getHangUpStream();
}

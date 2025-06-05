import 'dart:async';

import '../../../repository/webrtc_repository.dart';

class ListenRefusalUseCase {
  final WebrtcRepository _repository;

  ListenRefusalUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<String> call() => _repository.getRefusalStream();
}

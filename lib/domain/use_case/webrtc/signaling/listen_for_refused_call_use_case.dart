// domain/use_case/webrtc/signaling/listen_for_refused_call_use_case.dart
import 'dart:async';

import '../../../repository/webrtc_repository.dart';

class ListenForRefusedCallUseCase {
  final WebRTCRepository _repository;

  ListenForRefusedCallUseCase(this._repository);

  Stream<String> call() {
    return _repository.listenForRefusedCall();
  }
}

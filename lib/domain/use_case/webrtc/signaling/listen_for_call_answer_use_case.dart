// domain/use_case/webrtc/signaling/listen_for_call_answer_use_case.dart
import 'dart:async';

import '../../../model/call_answer_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenForCallAnswerUseCase {
  final WebRTCRepository _repository;

  ListenForCallAnswerUseCase(this._repository);

  Stream<CallAnswerModel> call() {
    return _repository.listenForCallAnswer();
  }
}

import 'dart:async';

import '../../../model/call_answer_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenAnswerUseCase {
  final WebrtcRepository _repository;

  ListenAnswerUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<CallAnswerModel> call() => _repository.getAnswerStream();
}

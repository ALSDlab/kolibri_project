// domain/use_case/webrtc/signaling/accept_incoming_call_use_case.dart
import 'package:kolibri_project/domain/model/call_answer_model.dart';

import '../../../repository/webrtc_repository.dart';

class AcceptIncomingCallUseCase {
  final WebRTCRepository _repository;

  AcceptIncomingCallUseCase(this._repository);

  void call(CallAnswerModel answer) {
    _repository.acceptIncomingCall(answer);
  }
}

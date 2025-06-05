import '../../../../data/core/result.dart';
import '../../../model/call_answer_model.dart';
import '../../../repository/webrtc_repository.dart';

class SendAnswerUseCase {
  final WebrtcRepository _repository;

  SendAnswerUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<void>> call(CallAnswerModel answer) =>
      _repository.sendAnswer(answer);
}

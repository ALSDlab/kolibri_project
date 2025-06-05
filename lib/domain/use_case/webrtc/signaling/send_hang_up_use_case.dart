import '../../../../data/core/result.dart';
import '../../../repository/webrtc_repository.dart';

class SendHangUpUseCase {
  final WebrtcRepository _repository;

  SendHangUpUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<void>> call({required String toId, required String fromId}) =>
      _repository.sendHangUp(toId: toId, fromId: fromId);
}

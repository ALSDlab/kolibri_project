import '../../../../data/core/result.dart';
import '../../../repository/webrtc_repository.dart';

class SendRefusalUseCase {
  final WebrtcRepository _repository;

  SendRefusalUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<void>> call({required String toId, required String fromId}) =>
      _repository.sendRefusal(toId: toId, fromId: fromId);
}

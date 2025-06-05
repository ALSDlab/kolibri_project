import '../../../../data/core/result.dart';
import '../../../model/ice_candidate_info_model.dart';
import '../../../repository/webrtc_repository.dart';

class SendIceCandidateUseCase {
  final WebrtcRepository _repository;

  SendIceCandidateUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<void>> call(IceCandidateInfoModel candidate) =>
      _repository.sendIceCandidate(candidate);
}

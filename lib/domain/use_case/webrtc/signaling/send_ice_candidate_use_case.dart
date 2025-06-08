// domain/use_case/webrtc/signaling/send_ice_candidate_use_case.dart
import '../../../model/ice_candidate_info_model.dart';
import '../../../repository/webrtc_repository.dart';

class SendIceCandidateUseCase {
  final WebRTCRepository _repository;

  SendIceCandidateUseCase(this._repository);

  void call(IceCandidateInfoModel candidate) {
    _repository.sendIceCandidate(candidate);
  }
}

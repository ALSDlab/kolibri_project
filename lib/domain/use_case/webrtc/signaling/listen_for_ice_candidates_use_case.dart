// domain/use_case/webrtc/signaling/listen_for_ice_candidates_use_case.dart
import 'dart:async';

import '../../../model/ice_candidate_info_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenForIceCandidatesUseCase {
  final WebRTCRepository _repository;

  ListenForIceCandidatesUseCase(this._repository);

  Stream<IceCandidateInfoModel> call() {
    return _repository.listenForIceCandidates();
  }
}

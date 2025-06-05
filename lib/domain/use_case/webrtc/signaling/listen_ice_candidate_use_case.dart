import 'dart:async';

import '../../../model/ice_candidate_info_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenIceCandidateUseCase {
  final WebrtcRepository _repository;

  ListenIceCandidateUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<IceCandidateInfoModel> call() => _repository.getIceCandidateStream();
}

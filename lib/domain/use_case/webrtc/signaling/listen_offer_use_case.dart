import 'dart:async';

import '../../../model/call_offer_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenOfferUseCase {
  final WebrtcRepository _repository;

  ListenOfferUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<CallOfferModel> call() => _repository.getOfferStream();
}

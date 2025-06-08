// domain/use_case/webrtc/signaling/listen_for_call_offers_use_case.dart
import 'dart:async';

import '../../../model/call_offer_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenForCallOffersUseCase {
  final WebRTCRepository _repository;

  ListenForCallOffersUseCase(this._repository);

  Stream<CallOfferModel> call() {
    return _repository.listenForCallOffers();
  }
}

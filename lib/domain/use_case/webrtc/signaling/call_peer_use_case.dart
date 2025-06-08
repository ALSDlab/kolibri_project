// domain/use_case/webrtc/signaling/call_peer_use_case.dart
import '../../../model/call_offer_model.dart';
import '../../../repository/webrtc_repository.dart';

class CallPeerUseCase {
  final WebRTCRepository _repository;

  CallPeerUseCase(this._repository);

  void call(CallOfferModel offer) {
    _repository.callPeer(offer);
  }
}

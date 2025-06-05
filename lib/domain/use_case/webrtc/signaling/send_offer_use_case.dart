import '../../../../data/core/result.dart';
import '../../../model/call_offer_model.dart';
import '../../../repository/webrtc_repository.dart';

class SendOfferUseCase {
  final WebrtcRepository _repository;

  SendOfferUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<void>> call(CallOfferModel offer) =>
      _repository.sendOffer(offer);
}

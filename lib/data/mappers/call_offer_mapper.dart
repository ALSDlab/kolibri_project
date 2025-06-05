import 'package:kolibri_project/data/dtos/call_offer_dto.dart';
import 'package:kolibri_project/domain/model/call_offer_model.dart';

class CallOfferMapper {
  static CallOfferModel fromDTO(CallOfferDto dto) {
    return CallOfferModel(
      fromId: dto.fromId ?? '',
      toId: dto.toId ?? '',
      sdp: dto.sdp ?? '',
      type: dto.type ?? '',
      audioOnly: dto.audioOnly ?? false,
    );
  }

  static CallOfferDto toDTO(CallOfferModel model) {
    return CallOfferDto(
      fromId: model.fromId,
      toId: model.toId,
      sdp: model.sdp,
      type: model.type,
      audioOnly: model.audioOnly,
    );
  }
}

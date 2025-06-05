import 'package:kolibri_project/data/dtos/call_answer_dto.dart';
import 'package:kolibri_project/domain/model/call_answer_model.dart';

class CallAnswerMapper {
  static CallAnswerModel fromDTO(CallAnswerDto dto) {
    return CallAnswerModel(
      fromId: dto.fromId ?? '',
      toId: dto.toId ?? '',
      sdp: dto.sdp ?? '',
      type: dto.type ?? '',
      audioOnly: dto.audioOnly ?? false,
    );
  }

  static CallAnswerDto toDTO(CallAnswerModel model) {
    return CallAnswerDto(
      fromId: model.fromId,
      toId: model.toId,
      sdp: model.sdp,
      type: model.type,
      audioOnly: model.audioOnly,
    );
  }
}

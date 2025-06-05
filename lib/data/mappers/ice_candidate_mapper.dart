import 'package:kolibri_project/data/dtos/ice_candidate_dto.dart';
import 'package:kolibri_project/domain/model/ice_candidate_info_model.dart';

class IceCandidateMapper {
  static IceCandidateInfoModel fromDTO(IceCandidateDto dto) {
    return IceCandidateInfoModel(
      candidate: dto.candidate ?? '',
      sdpMid: dto.sdpMid ?? '',
      sdpMLineIndex: dto.sdpMLineIndex ?? 0,
      to: dto.to ?? '',
    );
  }

  static IceCandidateDto toDTO(IceCandidateInfoModel model) {
    return IceCandidateDto(
      candidate: model.candidate,
      sdpMid: model.sdpMid,
      sdpMLineIndex: model.sdpMLineIndex,
      to: model.to,
    );
  }
}

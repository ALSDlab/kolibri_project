import 'package:freezed_annotation/freezed_annotation.dart';

part 'ice_candidate_info_model.freezed.dart';
part 'ice_candidate_info_model.g.dart';

@freezed
abstract class IceCandidateInfoModel with _$IceCandidateInfoModel {
  const factory IceCandidateInfoModel({
    @JsonKey(name: 'from') required String from,
    @JsonKey(name: 'to') required String to,
    @JsonKey(name: 'candidate') required String candidate,
    @JsonKey(name: 'sdpMid') required String sdpMid,
    @JsonKey(name: 'sdpMLineIndex') required int sdpMLineIndex,
  }) = _IceCandidateModel;

  factory IceCandidateInfoModel.fromJson(Map<String, dynamic> json) =>
      _$IceCandidateModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_answer_model.freezed.dart';
part 'call_answer_model.g.dart';

@freezed
abstract class CallAnswerModel with _$CallAnswerModel {
  const factory CallAnswerModel({
    @JsonKey(name: 'fromId') required String fromId,
    @JsonKey(name: 'toId') required String toId,
    @JsonKey(name: 'sdp') required String sdp,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'audioOnly') required bool audioOnly,
  }) = _CallAnswerModel;

  factory CallAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$CallAnswerModelFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_offer_model.freezed.dart';
part 'call_offer_model.g.dart';

@freezed
abstract class CallOfferModel with _$CallOfferModel {
  const factory CallOfferModel({
    @JsonKey(name: 'fromId') required String fromId,
    @JsonKey(name: 'toId') required String toId,
    @JsonKey(name: 'sdp') required String sdp,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'audioOnly') required bool audioOnly,
  }) = _CallOfferModel;

  factory CallOfferModel.fromJson(Map<String, dynamic> json) =>
      _$CallOfferModelFromJson(json);
}

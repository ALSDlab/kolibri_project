import 'package:freezed_annotation/freezed_annotation.dart';

part 'peer_user_model.freezed.dart';
part 'peer_user_model.g.dart';


@freezed
abstract class PeerUserModel with _$PeerUserModel {
  const factory PeerUserModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'thumbnailUrl') String? thumbnailUrl,
  }) = _PeerUserModel;

  factory PeerUserModel.fromJson(Map<String, dynamic> json) =>
      _$PeerUserModelFromJson(json);
}

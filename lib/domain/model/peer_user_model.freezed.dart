// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'peer_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PeerUserModel {

@JsonKey(name: 'id') String get id;@JsonKey(name: 'name') String? get name;@JsonKey(name: 'imageUrl') String? get imageUrl;@JsonKey(name: 'thumbnailUrl') String? get thumbnailUrl;
/// Create a copy of PeerUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeerUserModelCopyWith<PeerUserModel> get copyWith => _$PeerUserModelCopyWithImpl<PeerUserModel>(this as PeerUserModel, _$identity);

  /// Serializes this PeerUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeerUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,thumbnailUrl);

@override
String toString() {
  return 'PeerUserModel(id: $id, name: $name, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $PeerUserModelCopyWith<$Res>  {
  factory $PeerUserModelCopyWith(PeerUserModel value, $Res Function(PeerUserModel) _then) = _$PeerUserModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String? name,@JsonKey(name: 'imageUrl') String? imageUrl,@JsonKey(name: 'thumbnailUrl') String? thumbnailUrl
});




}
/// @nodoc
class _$PeerUserModelCopyWithImpl<$Res>
    implements $PeerUserModelCopyWith<$Res> {
  _$PeerUserModelCopyWithImpl(this._self, this._then);

  final PeerUserModel _self;
  final $Res Function(PeerUserModel) _then;

/// Create a copy of PeerUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? imageUrl = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PeerUserModel implements PeerUserModel {
  const _PeerUserModel({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'name') this.name, @JsonKey(name: 'imageUrl') this.imageUrl, @JsonKey(name: 'thumbnailUrl') this.thumbnailUrl});
  factory _PeerUserModel.fromJson(Map<String, dynamic> json) => _$PeerUserModelFromJson(json);

@override@JsonKey(name: 'id') final  String id;
@override@JsonKey(name: 'name') final  String? name;
@override@JsonKey(name: 'imageUrl') final  String? imageUrl;
@override@JsonKey(name: 'thumbnailUrl') final  String? thumbnailUrl;

/// Create a copy of PeerUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeerUserModelCopyWith<_PeerUserModel> get copyWith => __$PeerUserModelCopyWithImpl<_PeerUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeerUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeerUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl,thumbnailUrl);

@override
String toString() {
  return 'PeerUserModel(id: $id, name: $name, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$PeerUserModelCopyWith<$Res> implements $PeerUserModelCopyWith<$Res> {
  factory _$PeerUserModelCopyWith(_PeerUserModel value, $Res Function(_PeerUserModel) _then) = __$PeerUserModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') String id,@JsonKey(name: 'name') String? name,@JsonKey(name: 'imageUrl') String? imageUrl,@JsonKey(name: 'thumbnailUrl') String? thumbnailUrl
});




}
/// @nodoc
class __$PeerUserModelCopyWithImpl<$Res>
    implements _$PeerUserModelCopyWith<$Res> {
  __$PeerUserModelCopyWithImpl(this._self, this._then);

  final _PeerUserModel _self;
  final $Res Function(_PeerUserModel) _then;

/// Create a copy of PeerUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? imageUrl = freezed,Object? thumbnailUrl = freezed,}) {
  return _then(_PeerUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

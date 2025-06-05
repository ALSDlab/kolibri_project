// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditProfilePageState {

 bool get isLoading; bool get isThumbnailLoading; String get currentUser; String get email; String get name; String get comment; String get thumbnail; String get imageUrl; bool get isEmailValid; bool get isEmailVerified;
/// Create a copy of EditProfilePageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfilePageStateCopyWith<EditProfilePageState> get copyWith => _$EditProfilePageStateCopyWithImpl<EditProfilePageState>(this as EditProfilePageState, _$identity);

  /// Serializes this EditProfilePageState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfilePageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isThumbnailLoading, isThumbnailLoading) || other.isThumbnailLoading == isThumbnailLoading)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isEmailValid, isEmailValid) || other.isEmailValid == isEmailValid)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,isThumbnailLoading,currentUser,email,name,comment,thumbnail,imageUrl,isEmailValid,isEmailVerified);

@override
String toString() {
  return 'EditProfilePageState(isLoading: $isLoading, isThumbnailLoading: $isThumbnailLoading, currentUser: $currentUser, email: $email, name: $name, comment: $comment, thumbnail: $thumbnail, imageUrl: $imageUrl, isEmailValid: $isEmailValid, isEmailVerified: $isEmailVerified)';
}


}

/// @nodoc
abstract mixin class $EditProfilePageStateCopyWith<$Res>  {
  factory $EditProfilePageStateCopyWith(EditProfilePageState value, $Res Function(EditProfilePageState) _then) = _$EditProfilePageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isThumbnailLoading, String currentUser, String email, String name, String comment, String thumbnail, String imageUrl, bool isEmailValid, bool isEmailVerified
});




}
/// @nodoc
class _$EditProfilePageStateCopyWithImpl<$Res>
    implements $EditProfilePageStateCopyWith<$Res> {
  _$EditProfilePageStateCopyWithImpl(this._self, this._then);

  final EditProfilePageState _self;
  final $Res Function(EditProfilePageState) _then;

/// Create a copy of EditProfilePageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isThumbnailLoading = null,Object? currentUser = null,Object? email = null,Object? name = null,Object? comment = null,Object? thumbnail = null,Object? imageUrl = null,Object? isEmailValid = null,Object? isEmailVerified = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isThumbnailLoading: null == isThumbnailLoading ? _self.isThumbnailLoading : isThumbnailLoading // ignore: cast_nullable_to_non_nullable
as bool,currentUser: null == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,isEmailValid: null == isEmailValid ? _self.isEmailValid : isEmailValid // ignore: cast_nullable_to_non_nullable
as bool,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EditProfilePageState implements EditProfilePageState {
  const _EditProfilePageState({this.isLoading = false, this.isThumbnailLoading = false, this.currentUser = '', this.email = '', this.name = '', this.comment = '', this.thumbnail = '', this.imageUrl = '', this.isEmailValid = false, this.isEmailVerified = false});
  factory _EditProfilePageState.fromJson(Map<String, dynamic> json) => _$EditProfilePageStateFromJson(json);

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isThumbnailLoading;
@override@JsonKey() final  String currentUser;
@override@JsonKey() final  String email;
@override@JsonKey() final  String name;
@override@JsonKey() final  String comment;
@override@JsonKey() final  String thumbnail;
@override@JsonKey() final  String imageUrl;
@override@JsonKey() final  bool isEmailValid;
@override@JsonKey() final  bool isEmailVerified;

/// Create a copy of EditProfilePageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditProfilePageStateCopyWith<_EditProfilePageState> get copyWith => __$EditProfilePageStateCopyWithImpl<_EditProfilePageState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EditProfilePageStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditProfilePageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isThumbnailLoading, isThumbnailLoading) || other.isThumbnailLoading == isThumbnailLoading)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isEmailValid, isEmailValid) || other.isEmailValid == isEmailValid)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,isThumbnailLoading,currentUser,email,name,comment,thumbnail,imageUrl,isEmailValid,isEmailVerified);

@override
String toString() {
  return 'EditProfilePageState(isLoading: $isLoading, isThumbnailLoading: $isThumbnailLoading, currentUser: $currentUser, email: $email, name: $name, comment: $comment, thumbnail: $thumbnail, imageUrl: $imageUrl, isEmailValid: $isEmailValid, isEmailVerified: $isEmailVerified)';
}


}

/// @nodoc
abstract mixin class _$EditProfilePageStateCopyWith<$Res> implements $EditProfilePageStateCopyWith<$Res> {
  factory _$EditProfilePageStateCopyWith(_EditProfilePageState value, $Res Function(_EditProfilePageState) _then) = __$EditProfilePageStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isThumbnailLoading, String currentUser, String email, String name, String comment, String thumbnail, String imageUrl, bool isEmailValid, bool isEmailVerified
});




}
/// @nodoc
class __$EditProfilePageStateCopyWithImpl<$Res>
    implements _$EditProfilePageStateCopyWith<$Res> {
  __$EditProfilePageStateCopyWithImpl(this._self, this._then);

  final _EditProfilePageState _self;
  final $Res Function(_EditProfilePageState) _then;

/// Create a copy of EditProfilePageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isThumbnailLoading = null,Object? currentUser = null,Object? email = null,Object? name = null,Object? comment = null,Object? thumbnail = null,Object? imageUrl = null,Object? isEmailValid = null,Object? isEmailVerified = null,}) {
  return _then(_EditProfilePageState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isThumbnailLoading: null == isThumbnailLoading ? _self.isThumbnailLoading : isThumbnailLoading // ignore: cast_nullable_to_non_nullable
as bool,currentUser: null == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,isEmailValid: null == isEmailValid ? _self.isEmailValid : isEmailValid // ignore: cast_nullable_to_non_nullable
as bool,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

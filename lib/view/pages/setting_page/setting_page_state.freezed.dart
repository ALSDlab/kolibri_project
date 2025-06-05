// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setting_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingPageState {

 bool get tapped; bool get isLoading; String get currentUser; String get userName; String get thumbnailUrl; String get fullImageUrl;
/// Create a copy of SettingPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingPageStateCopyWith<SettingPageState> get copyWith => _$SettingPageStateCopyWithImpl<SettingPageState>(this as SettingPageState, _$identity);

  /// Serializes this SettingPageState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingPageState&&(identical(other.tapped, tapped) || other.tapped == tapped)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fullImageUrl, fullImageUrl) || other.fullImageUrl == fullImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tapped,isLoading,currentUser,userName,thumbnailUrl,fullImageUrl);

@override
String toString() {
  return 'SettingPageState(tapped: $tapped, isLoading: $isLoading, currentUser: $currentUser, userName: $userName, thumbnailUrl: $thumbnailUrl, fullImageUrl: $fullImageUrl)';
}


}

/// @nodoc
abstract mixin class $SettingPageStateCopyWith<$Res>  {
  factory $SettingPageStateCopyWith(SettingPageState value, $Res Function(SettingPageState) _then) = _$SettingPageStateCopyWithImpl;
@useResult
$Res call({
 bool tapped, bool isLoading, String currentUser, String userName, String thumbnailUrl, String fullImageUrl
});




}
/// @nodoc
class _$SettingPageStateCopyWithImpl<$Res>
    implements $SettingPageStateCopyWith<$Res> {
  _$SettingPageStateCopyWithImpl(this._self, this._then);

  final SettingPageState _self;
  final $Res Function(SettingPageState) _then;

/// Create a copy of SettingPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tapped = null,Object? isLoading = null,Object? currentUser = null,Object? userName = null,Object? thumbnailUrl = null,Object? fullImageUrl = null,}) {
  return _then(_self.copyWith(
tapped: null == tapped ? _self.tapped : tapped // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentUser: null == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,fullImageUrl: null == fullImageUrl ? _self.fullImageUrl : fullImageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SettingPageState implements SettingPageState {
  const _SettingPageState({this.tapped = false, this.isLoading = false, this.currentUser = '', this.userName = '', this.thumbnailUrl = '', this.fullImageUrl = ''});
  factory _SettingPageState.fromJson(Map<String, dynamic> json) => _$SettingPageStateFromJson(json);

@override@JsonKey() final  bool tapped;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String currentUser;
@override@JsonKey() final  String userName;
@override@JsonKey() final  String thumbnailUrl;
@override@JsonKey() final  String fullImageUrl;

/// Create a copy of SettingPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingPageStateCopyWith<_SettingPageState> get copyWith => __$SettingPageStateCopyWithImpl<_SettingPageState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingPageStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingPageState&&(identical(other.tapped, tapped) || other.tapped == tapped)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.fullImageUrl, fullImageUrl) || other.fullImageUrl == fullImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tapped,isLoading,currentUser,userName,thumbnailUrl,fullImageUrl);

@override
String toString() {
  return 'SettingPageState(tapped: $tapped, isLoading: $isLoading, currentUser: $currentUser, userName: $userName, thumbnailUrl: $thumbnailUrl, fullImageUrl: $fullImageUrl)';
}


}

/// @nodoc
abstract mixin class _$SettingPageStateCopyWith<$Res> implements $SettingPageStateCopyWith<$Res> {
  factory _$SettingPageStateCopyWith(_SettingPageState value, $Res Function(_SettingPageState) _then) = __$SettingPageStateCopyWithImpl;
@override @useResult
$Res call({
 bool tapped, bool isLoading, String currentUser, String userName, String thumbnailUrl, String fullImageUrl
});




}
/// @nodoc
class __$SettingPageStateCopyWithImpl<$Res>
    implements _$SettingPageStateCopyWith<$Res> {
  __$SettingPageStateCopyWithImpl(this._self, this._then);

  final _SettingPageState _self;
  final $Res Function(_SettingPageState) _then;

/// Create a copy of SettingPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tapped = null,Object? isLoading = null,Object? currentUser = null,Object? userName = null,Object? thumbnailUrl = null,Object? fullImageUrl = null,}) {
  return _then(_SettingPageState(
tapped: null == tapped ? _self.tapped : tapped // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,currentUser: null == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,fullImageUrl: null == fullImageUrl ? _self.fullImageUrl : fullImageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

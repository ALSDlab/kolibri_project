// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginPageState {

 bool get isLoading; bool get loginCheck; bool get isDialogShowing; String get errorEmailText; String get errorPasswordText;
/// Create a copy of LoginPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginPageStateCopyWith<LoginPageState> get copyWith => _$LoginPageStateCopyWithImpl<LoginPageState>(this as LoginPageState, _$identity);

  /// Serializes this LoginPageState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loginCheck, loginCheck) || other.loginCheck == loginCheck)&&(identical(other.isDialogShowing, isDialogShowing) || other.isDialogShowing == isDialogShowing)&&(identical(other.errorEmailText, errorEmailText) || other.errorEmailText == errorEmailText)&&(identical(other.errorPasswordText, errorPasswordText) || other.errorPasswordText == errorPasswordText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,loginCheck,isDialogShowing,errorEmailText,errorPasswordText);

@override
String toString() {
  return 'LoginPageState(isLoading: $isLoading, loginCheck: $loginCheck, isDialogShowing: $isDialogShowing, errorEmailText: $errorEmailText, errorPasswordText: $errorPasswordText)';
}


}

/// @nodoc
abstract mixin class $LoginPageStateCopyWith<$Res>  {
  factory $LoginPageStateCopyWith(LoginPageState value, $Res Function(LoginPageState) _then) = _$LoginPageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool loginCheck, bool isDialogShowing, String errorEmailText, String errorPasswordText
});




}
/// @nodoc
class _$LoginPageStateCopyWithImpl<$Res>
    implements $LoginPageStateCopyWith<$Res> {
  _$LoginPageStateCopyWithImpl(this._self, this._then);

  final LoginPageState _self;
  final $Res Function(LoginPageState) _then;

/// Create a copy of LoginPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? loginCheck = null,Object? isDialogShowing = null,Object? errorEmailText = null,Object? errorPasswordText = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loginCheck: null == loginCheck ? _self.loginCheck : loginCheck // ignore: cast_nullable_to_non_nullable
as bool,isDialogShowing: null == isDialogShowing ? _self.isDialogShowing : isDialogShowing // ignore: cast_nullable_to_non_nullable
as bool,errorEmailText: null == errorEmailText ? _self.errorEmailText : errorEmailText // ignore: cast_nullable_to_non_nullable
as String,errorPasswordText: null == errorPasswordText ? _self.errorPasswordText : errorPasswordText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LoginPageState implements LoginPageState {
  const _LoginPageState({this.isLoading = false, this.loginCheck = false, this.isDialogShowing = false, this.errorEmailText = '', this.errorPasswordText = ''});
  factory _LoginPageState.fromJson(Map<String, dynamic> json) => _$LoginPageStateFromJson(json);

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool loginCheck;
@override@JsonKey() final  bool isDialogShowing;
@override@JsonKey() final  String errorEmailText;
@override@JsonKey() final  String errorPasswordText;

/// Create a copy of LoginPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginPageStateCopyWith<_LoginPageState> get copyWith => __$LoginPageStateCopyWithImpl<_LoginPageState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginPageStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.loginCheck, loginCheck) || other.loginCheck == loginCheck)&&(identical(other.isDialogShowing, isDialogShowing) || other.isDialogShowing == isDialogShowing)&&(identical(other.errorEmailText, errorEmailText) || other.errorEmailText == errorEmailText)&&(identical(other.errorPasswordText, errorPasswordText) || other.errorPasswordText == errorPasswordText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,loginCheck,isDialogShowing,errorEmailText,errorPasswordText);

@override
String toString() {
  return 'LoginPageState(isLoading: $isLoading, loginCheck: $loginCheck, isDialogShowing: $isDialogShowing, errorEmailText: $errorEmailText, errorPasswordText: $errorPasswordText)';
}


}

/// @nodoc
abstract mixin class _$LoginPageStateCopyWith<$Res> implements $LoginPageStateCopyWith<$Res> {
  factory _$LoginPageStateCopyWith(_LoginPageState value, $Res Function(_LoginPageState) _then) = __$LoginPageStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool loginCheck, bool isDialogShowing, String errorEmailText, String errorPasswordText
});




}
/// @nodoc
class __$LoginPageStateCopyWithImpl<$Res>
    implements _$LoginPageStateCopyWith<$Res> {
  __$LoginPageStateCopyWithImpl(this._self, this._then);

  final _LoginPageState _self;
  final $Res Function(_LoginPageState) _then;

/// Create a copy of LoginPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? loginCheck = null,Object? isDialogShowing = null,Object? errorEmailText = null,Object? errorPasswordText = null,}) {
  return _then(_LoginPageState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,loginCheck: null == loginCheck ? _self.loginCheck : loginCheck // ignore: cast_nullable_to_non_nullable
as bool,isDialogShowing: null == isDialogShowing ? _self.isDialogShowing : isDialogShowing // ignore: cast_nullable_to_non_nullable
as bool,errorEmailText: null == errorEmailText ? _self.errorEmailText : errorEmailText // ignore: cast_nullable_to_non_nullable
as String,errorPasswordText: null == errorPasswordText ? _self.errorPasswordText : errorPasswordText // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

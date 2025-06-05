// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignupPageState {

 bool get isLoading; bool get isVerifying; bool get tapped; String get errorEmailText; String get errorPasswordText; String get errorConfirmPasswordText; bool get isEmailValid; bool get hasUpperCase; bool get hasLowerCase; bool get hasDigit; bool get isAtLeast6Chars;
/// Create a copy of SignupPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupPageStateCopyWith<SignupPageState> get copyWith => _$SignupPageStateCopyWithImpl<SignupPageState>(this as SignupPageState, _$identity);

  /// Serializes this SignupPageState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isVerifying, isVerifying) || other.isVerifying == isVerifying)&&(identical(other.tapped, tapped) || other.tapped == tapped)&&(identical(other.errorEmailText, errorEmailText) || other.errorEmailText == errorEmailText)&&(identical(other.errorPasswordText, errorPasswordText) || other.errorPasswordText == errorPasswordText)&&(identical(other.errorConfirmPasswordText, errorConfirmPasswordText) || other.errorConfirmPasswordText == errorConfirmPasswordText)&&(identical(other.isEmailValid, isEmailValid) || other.isEmailValid == isEmailValid)&&(identical(other.hasUpperCase, hasUpperCase) || other.hasUpperCase == hasUpperCase)&&(identical(other.hasLowerCase, hasLowerCase) || other.hasLowerCase == hasLowerCase)&&(identical(other.hasDigit, hasDigit) || other.hasDigit == hasDigit)&&(identical(other.isAtLeast6Chars, isAtLeast6Chars) || other.isAtLeast6Chars == isAtLeast6Chars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,isVerifying,tapped,errorEmailText,errorPasswordText,errorConfirmPasswordText,isEmailValid,hasUpperCase,hasLowerCase,hasDigit,isAtLeast6Chars);

@override
String toString() {
  return 'SignupPageState(isLoading: $isLoading, isVerifying: $isVerifying, tapped: $tapped, errorEmailText: $errorEmailText, errorPasswordText: $errorPasswordText, errorConfirmPasswordText: $errorConfirmPasswordText, isEmailValid: $isEmailValid, hasUpperCase: $hasUpperCase, hasLowerCase: $hasLowerCase, hasDigit: $hasDigit, isAtLeast6Chars: $isAtLeast6Chars)';
}


}

/// @nodoc
abstract mixin class $SignupPageStateCopyWith<$Res>  {
  factory $SignupPageStateCopyWith(SignupPageState value, $Res Function(SignupPageState) _then) = _$SignupPageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isVerifying, bool tapped, String errorEmailText, String errorPasswordText, String errorConfirmPasswordText, bool isEmailValid, bool hasUpperCase, bool hasLowerCase, bool hasDigit, bool isAtLeast6Chars
});




}
/// @nodoc
class _$SignupPageStateCopyWithImpl<$Res>
    implements $SignupPageStateCopyWith<$Res> {
  _$SignupPageStateCopyWithImpl(this._self, this._then);

  final SignupPageState _self;
  final $Res Function(SignupPageState) _then;

/// Create a copy of SignupPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isVerifying = null,Object? tapped = null,Object? errorEmailText = null,Object? errorPasswordText = null,Object? errorConfirmPasswordText = null,Object? isEmailValid = null,Object? hasUpperCase = null,Object? hasLowerCase = null,Object? hasDigit = null,Object? isAtLeast6Chars = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isVerifying: null == isVerifying ? _self.isVerifying : isVerifying // ignore: cast_nullable_to_non_nullable
as bool,tapped: null == tapped ? _self.tapped : tapped // ignore: cast_nullable_to_non_nullable
as bool,errorEmailText: null == errorEmailText ? _self.errorEmailText : errorEmailText // ignore: cast_nullable_to_non_nullable
as String,errorPasswordText: null == errorPasswordText ? _self.errorPasswordText : errorPasswordText // ignore: cast_nullable_to_non_nullable
as String,errorConfirmPasswordText: null == errorConfirmPasswordText ? _self.errorConfirmPasswordText : errorConfirmPasswordText // ignore: cast_nullable_to_non_nullable
as String,isEmailValid: null == isEmailValid ? _self.isEmailValid : isEmailValid // ignore: cast_nullable_to_non_nullable
as bool,hasUpperCase: null == hasUpperCase ? _self.hasUpperCase : hasUpperCase // ignore: cast_nullable_to_non_nullable
as bool,hasLowerCase: null == hasLowerCase ? _self.hasLowerCase : hasLowerCase // ignore: cast_nullable_to_non_nullable
as bool,hasDigit: null == hasDigit ? _self.hasDigit : hasDigit // ignore: cast_nullable_to_non_nullable
as bool,isAtLeast6Chars: null == isAtLeast6Chars ? _self.isAtLeast6Chars : isAtLeast6Chars // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SignupPageState implements SignupPageState {
  const _SignupPageState({this.isLoading = false, this.isVerifying = false, this.tapped = false, this.errorEmailText = '', this.errorPasswordText = '', this.errorConfirmPasswordText = '', this.isEmailValid = false, this.hasUpperCase = false, this.hasLowerCase = false, this.hasDigit = false, this.isAtLeast6Chars = false});
  factory _SignupPageState.fromJson(Map<String, dynamic> json) => _$SignupPageStateFromJson(json);

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isVerifying;
@override@JsonKey() final  bool tapped;
@override@JsonKey() final  String errorEmailText;
@override@JsonKey() final  String errorPasswordText;
@override@JsonKey() final  String errorConfirmPasswordText;
@override@JsonKey() final  bool isEmailValid;
@override@JsonKey() final  bool hasUpperCase;
@override@JsonKey() final  bool hasLowerCase;
@override@JsonKey() final  bool hasDigit;
@override@JsonKey() final  bool isAtLeast6Chars;

/// Create a copy of SignupPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupPageStateCopyWith<_SignupPageState> get copyWith => __$SignupPageStateCopyWithImpl<_SignupPageState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupPageStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isVerifying, isVerifying) || other.isVerifying == isVerifying)&&(identical(other.tapped, tapped) || other.tapped == tapped)&&(identical(other.errorEmailText, errorEmailText) || other.errorEmailText == errorEmailText)&&(identical(other.errorPasswordText, errorPasswordText) || other.errorPasswordText == errorPasswordText)&&(identical(other.errorConfirmPasswordText, errorConfirmPasswordText) || other.errorConfirmPasswordText == errorConfirmPasswordText)&&(identical(other.isEmailValid, isEmailValid) || other.isEmailValid == isEmailValid)&&(identical(other.hasUpperCase, hasUpperCase) || other.hasUpperCase == hasUpperCase)&&(identical(other.hasLowerCase, hasLowerCase) || other.hasLowerCase == hasLowerCase)&&(identical(other.hasDigit, hasDigit) || other.hasDigit == hasDigit)&&(identical(other.isAtLeast6Chars, isAtLeast6Chars) || other.isAtLeast6Chars == isAtLeast6Chars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,isVerifying,tapped,errorEmailText,errorPasswordText,errorConfirmPasswordText,isEmailValid,hasUpperCase,hasLowerCase,hasDigit,isAtLeast6Chars);

@override
String toString() {
  return 'SignupPageState(isLoading: $isLoading, isVerifying: $isVerifying, tapped: $tapped, errorEmailText: $errorEmailText, errorPasswordText: $errorPasswordText, errorConfirmPasswordText: $errorConfirmPasswordText, isEmailValid: $isEmailValid, hasUpperCase: $hasUpperCase, hasLowerCase: $hasLowerCase, hasDigit: $hasDigit, isAtLeast6Chars: $isAtLeast6Chars)';
}


}

/// @nodoc
abstract mixin class _$SignupPageStateCopyWith<$Res> implements $SignupPageStateCopyWith<$Res> {
  factory _$SignupPageStateCopyWith(_SignupPageState value, $Res Function(_SignupPageState) _then) = __$SignupPageStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isVerifying, bool tapped, String errorEmailText, String errorPasswordText, String errorConfirmPasswordText, bool isEmailValid, bool hasUpperCase, bool hasLowerCase, bool hasDigit, bool isAtLeast6Chars
});




}
/// @nodoc
class __$SignupPageStateCopyWithImpl<$Res>
    implements _$SignupPageStateCopyWith<$Res> {
  __$SignupPageStateCopyWithImpl(this._self, this._then);

  final _SignupPageState _self;
  final $Res Function(_SignupPageState) _then;

/// Create a copy of SignupPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isVerifying = null,Object? tapped = null,Object? errorEmailText = null,Object? errorPasswordText = null,Object? errorConfirmPasswordText = null,Object? isEmailValid = null,Object? hasUpperCase = null,Object? hasLowerCase = null,Object? hasDigit = null,Object? isAtLeast6Chars = null,}) {
  return _then(_SignupPageState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isVerifying: null == isVerifying ? _self.isVerifying : isVerifying // ignore: cast_nullable_to_non_nullable
as bool,tapped: null == tapped ? _self.tapped : tapped // ignore: cast_nullable_to_non_nullable
as bool,errorEmailText: null == errorEmailText ? _self.errorEmailText : errorEmailText // ignore: cast_nullable_to_non_nullable
as String,errorPasswordText: null == errorPasswordText ? _self.errorPasswordText : errorPasswordText // ignore: cast_nullable_to_non_nullable
as String,errorConfirmPasswordText: null == errorConfirmPasswordText ? _self.errorConfirmPasswordText : errorConfirmPasswordText // ignore: cast_nullable_to_non_nullable
as String,isEmailValid: null == isEmailValid ? _self.isEmailValid : isEmailValid // ignore: cast_nullable_to_non_nullable
as bool,hasUpperCase: null == hasUpperCase ? _self.hasUpperCase : hasUpperCase // ignore: cast_nullable_to_non_nullable
as bool,hasLowerCase: null == hasLowerCase ? _self.hasLowerCase : hasLowerCase // ignore: cast_nullable_to_non_nullable
as bool,hasDigit: null == hasDigit ? _self.hasDigit : hasDigit // ignore: cast_nullable_to_non_nullable
as bool,isAtLeast6Chars: null == isAtLeast6Chars ? _self.isAtLeast6Chars : isAtLeast6Chars // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

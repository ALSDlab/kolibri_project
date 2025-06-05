// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_answer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallAnswerModel {

@JsonKey(name: 'fromId') String get fromId;@JsonKey(name: 'toId') String get toId;@JsonKey(name: 'sdp') String get sdp;@JsonKey(name: 'type') String get type;@JsonKey(name: 'audioOnly') bool get audioOnly;
/// Create a copy of CallAnswerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAnswerModelCopyWith<CallAnswerModel> get copyWith => _$CallAnswerModelCopyWithImpl<CallAnswerModel>(this as CallAnswerModel, _$identity);

  /// Serializes this CallAnswerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAnswerModel&&(identical(other.fromId, fromId) || other.fromId == fromId)&&(identical(other.toId, toId) || other.toId == toId)&&(identical(other.sdp, sdp) || other.sdp == sdp)&&(identical(other.type, type) || other.type == type)&&(identical(other.audioOnly, audioOnly) || other.audioOnly == audioOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromId,toId,sdp,type,audioOnly);

@override
String toString() {
  return 'CallAnswerModel(fromId: $fromId, toId: $toId, sdp: $sdp, type: $type, audioOnly: $audioOnly)';
}


}

/// @nodoc
abstract mixin class $CallAnswerModelCopyWith<$Res>  {
  factory $CallAnswerModelCopyWith(CallAnswerModel value, $Res Function(CallAnswerModel) _then) = _$CallAnswerModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'fromId') String fromId,@JsonKey(name: 'toId') String toId,@JsonKey(name: 'sdp') String sdp,@JsonKey(name: 'type') String type,@JsonKey(name: 'audioOnly') bool audioOnly
});




}
/// @nodoc
class _$CallAnswerModelCopyWithImpl<$Res>
    implements $CallAnswerModelCopyWith<$Res> {
  _$CallAnswerModelCopyWithImpl(this._self, this._then);

  final CallAnswerModel _self;
  final $Res Function(CallAnswerModel) _then;

/// Create a copy of CallAnswerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromId = null,Object? toId = null,Object? sdp = null,Object? type = null,Object? audioOnly = null,}) {
  return _then(_self.copyWith(
fromId: null == fromId ? _self.fromId : fromId // ignore: cast_nullable_to_non_nullable
as String,toId: null == toId ? _self.toId : toId // ignore: cast_nullable_to_non_nullable
as String,sdp: null == sdp ? _self.sdp : sdp // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,audioOnly: null == audioOnly ? _self.audioOnly : audioOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CallAnswerModel implements CallAnswerModel {
  const _CallAnswerModel({@JsonKey(name: 'fromId') required this.fromId, @JsonKey(name: 'toId') required this.toId, @JsonKey(name: 'sdp') required this.sdp, @JsonKey(name: 'type') required this.type, @JsonKey(name: 'audioOnly') required this.audioOnly});
  factory _CallAnswerModel.fromJson(Map<String, dynamic> json) => _$CallAnswerModelFromJson(json);

@override@JsonKey(name: 'fromId') final  String fromId;
@override@JsonKey(name: 'toId') final  String toId;
@override@JsonKey(name: 'sdp') final  String sdp;
@override@JsonKey(name: 'type') final  String type;
@override@JsonKey(name: 'audioOnly') final  bool audioOnly;

/// Create a copy of CallAnswerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallAnswerModelCopyWith<_CallAnswerModel> get copyWith => __$CallAnswerModelCopyWithImpl<_CallAnswerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallAnswerModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallAnswerModel&&(identical(other.fromId, fromId) || other.fromId == fromId)&&(identical(other.toId, toId) || other.toId == toId)&&(identical(other.sdp, sdp) || other.sdp == sdp)&&(identical(other.type, type) || other.type == type)&&(identical(other.audioOnly, audioOnly) || other.audioOnly == audioOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromId,toId,sdp,type,audioOnly);

@override
String toString() {
  return 'CallAnswerModel(fromId: $fromId, toId: $toId, sdp: $sdp, type: $type, audioOnly: $audioOnly)';
}


}

/// @nodoc
abstract mixin class _$CallAnswerModelCopyWith<$Res> implements $CallAnswerModelCopyWith<$Res> {
  factory _$CallAnswerModelCopyWith(_CallAnswerModel value, $Res Function(_CallAnswerModel) _then) = __$CallAnswerModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'fromId') String fromId,@JsonKey(name: 'toId') String toId,@JsonKey(name: 'sdp') String sdp,@JsonKey(name: 'type') String type,@JsonKey(name: 'audioOnly') bool audioOnly
});




}
/// @nodoc
class __$CallAnswerModelCopyWithImpl<$Res>
    implements _$CallAnswerModelCopyWith<$Res> {
  __$CallAnswerModelCopyWithImpl(this._self, this._then);

  final _CallAnswerModel _self;
  final $Res Function(_CallAnswerModel) _then;

/// Create a copy of CallAnswerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromId = null,Object? toId = null,Object? sdp = null,Object? type = null,Object? audioOnly = null,}) {
  return _then(_CallAnswerModel(
fromId: null == fromId ? _self.fromId : fromId // ignore: cast_nullable_to_non_nullable
as String,toId: null == toId ? _self.toId : toId // ignore: cast_nullable_to_non_nullable
as String,sdp: null == sdp ? _self.sdp : sdp // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,audioOnly: null == audioOnly ? _self.audioOnly : audioOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ice_candidate_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
IceCandidateInfoModel _$IceCandidateInfoModelFromJson(
  Map<String, dynamic> json
) {
    return _IceCandidateModel.fromJson(
      json
    );
}

/// @nodoc
mixin _$IceCandidateInfoModel {

@JsonKey(name: 'from') String get from;@JsonKey(name: 'to') String get to;@JsonKey(name: 'candidate') String get candidate;@JsonKey(name: 'sdpMid') String get sdpMid;@JsonKey(name: 'sdpMLineIndex') int get sdpMLineIndex;
/// Create a copy of IceCandidateInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IceCandidateInfoModelCopyWith<IceCandidateInfoModel> get copyWith => _$IceCandidateInfoModelCopyWithImpl<IceCandidateInfoModel>(this as IceCandidateInfoModel, _$identity);

  /// Serializes this IceCandidateInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IceCandidateInfoModel&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.candidate, candidate) || other.candidate == candidate)&&(identical(other.sdpMid, sdpMid) || other.sdpMid == sdpMid)&&(identical(other.sdpMLineIndex, sdpMLineIndex) || other.sdpMLineIndex == sdpMLineIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,candidate,sdpMid,sdpMLineIndex);

@override
String toString() {
  return 'IceCandidateInfoModel(from: $from, to: $to, candidate: $candidate, sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex)';
}


}

/// @nodoc
abstract mixin class $IceCandidateInfoModelCopyWith<$Res>  {
  factory $IceCandidateInfoModelCopyWith(IceCandidateInfoModel value, $Res Function(IceCandidateInfoModel) _then) = _$IceCandidateInfoModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'from') String from,@JsonKey(name: 'to') String to,@JsonKey(name: 'candidate') String candidate,@JsonKey(name: 'sdpMid') String sdpMid,@JsonKey(name: 'sdpMLineIndex') int sdpMLineIndex
});




}
/// @nodoc
class _$IceCandidateInfoModelCopyWithImpl<$Res>
    implements $IceCandidateInfoModelCopyWith<$Res> {
  _$IceCandidateInfoModelCopyWithImpl(this._self, this._then);

  final IceCandidateInfoModel _self;
  final $Res Function(IceCandidateInfoModel) _then;

/// Create a copy of IceCandidateInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? candidate = null,Object? sdpMid = null,Object? sdpMLineIndex = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,candidate: null == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as String,sdpMid: null == sdpMid ? _self.sdpMid : sdpMid // ignore: cast_nullable_to_non_nullable
as String,sdpMLineIndex: null == sdpMLineIndex ? _self.sdpMLineIndex : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _IceCandidateModel implements IceCandidateInfoModel {
  const _IceCandidateModel({@JsonKey(name: 'from') required this.from, @JsonKey(name: 'to') required this.to, @JsonKey(name: 'candidate') required this.candidate, @JsonKey(name: 'sdpMid') required this.sdpMid, @JsonKey(name: 'sdpMLineIndex') required this.sdpMLineIndex});
  factory _IceCandidateModel.fromJson(Map<String, dynamic> json) => _$IceCandidateModelFromJson(json);

@override@JsonKey(name: 'from') final  String from;
@override@JsonKey(name: 'to') final  String to;
@override@JsonKey(name: 'candidate') final  String candidate;
@override@JsonKey(name: 'sdpMid') final  String sdpMid;
@override@JsonKey(name: 'sdpMLineIndex') final  int sdpMLineIndex;

/// Create a copy of IceCandidateInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IceCandidateModelCopyWith<_IceCandidateModel> get copyWith => __$IceCandidateModelCopyWithImpl<_IceCandidateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IceCandidateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IceCandidateModel&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.candidate, candidate) || other.candidate == candidate)&&(identical(other.sdpMid, sdpMid) || other.sdpMid == sdpMid)&&(identical(other.sdpMLineIndex, sdpMLineIndex) || other.sdpMLineIndex == sdpMLineIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,candidate,sdpMid,sdpMLineIndex);

@override
String toString() {
  return 'IceCandidateInfoModel(from: $from, to: $to, candidate: $candidate, sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex)';
}


}

/// @nodoc
abstract mixin class _$IceCandidateModelCopyWith<$Res> implements $IceCandidateInfoModelCopyWith<$Res> {
  factory _$IceCandidateModelCopyWith(_IceCandidateModel value, $Res Function(_IceCandidateModel) _then) = __$IceCandidateModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'from') String from,@JsonKey(name: 'to') String to,@JsonKey(name: 'candidate') String candidate,@JsonKey(name: 'sdpMid') String sdpMid,@JsonKey(name: 'sdpMLineIndex') int sdpMLineIndex
});




}
/// @nodoc
class __$IceCandidateModelCopyWithImpl<$Res>
    implements _$IceCandidateModelCopyWith<$Res> {
  __$IceCandidateModelCopyWithImpl(this._self, this._then);

  final _IceCandidateModel _self;
  final $Res Function(_IceCandidateModel) _then;

/// Create a copy of IceCandidateInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? candidate = null,Object? sdpMid = null,Object? sdpMLineIndex = null,}) {
  return _then(_IceCandidateModel(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,candidate: null == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as String,sdpMid: null == sdpMid ? _self.sdpMid : sdpMid // ignore: cast_nullable_to_non_nullable
as String,sdpMLineIndex: null == sdpMLineIndex ? _self.sdpMLineIndex : sdpMLineIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

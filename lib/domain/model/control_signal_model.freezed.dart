// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_signal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ControlSignalModel {

@JsonKey(name: 'to') String get to;@JsonKey(name: 'type') ControlSignalType get type;@JsonKey(name: 'angle') double? get angle;@JsonKey(name: 'intensity') double? get intensity;@JsonKey(name: 'dx') double? get dx;@JsonKey(name: 'dy') double? get dy;@JsonKey(name: 'scale') double? get scale;
/// Create a copy of ControlSignalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ControlSignalModelCopyWith<ControlSignalModel> get copyWith => _$ControlSignalModelCopyWithImpl<ControlSignalModel>(this as ControlSignalModel, _$identity);

  /// Serializes this ControlSignalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ControlSignalModel&&(identical(other.to, to) || other.to == to)&&(identical(other.type, type) || other.type == type)&&(identical(other.angle, angle) || other.angle == angle)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy)&&(identical(other.scale, scale) || other.scale == scale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,to,type,angle,intensity,dx,dy,scale);

@override
String toString() {
  return 'ControlSignalModel(to: $to, type: $type, angle: $angle, intensity: $intensity, dx: $dx, dy: $dy, scale: $scale)';
}


}

/// @nodoc
abstract mixin class $ControlSignalModelCopyWith<$Res>  {
  factory $ControlSignalModelCopyWith(ControlSignalModel value, $Res Function(ControlSignalModel) _then) = _$ControlSignalModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'to') String to,@JsonKey(name: 'type') ControlSignalType type,@JsonKey(name: 'angle') double? angle,@JsonKey(name: 'intensity') double? intensity,@JsonKey(name: 'dx') double? dx,@JsonKey(name: 'dy') double? dy,@JsonKey(name: 'scale') double? scale
});




}
/// @nodoc
class _$ControlSignalModelCopyWithImpl<$Res>
    implements $ControlSignalModelCopyWith<$Res> {
  _$ControlSignalModelCopyWithImpl(this._self, this._then);

  final ControlSignalModel _self;
  final $Res Function(ControlSignalModel) _then;

/// Create a copy of ControlSignalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? to = null,Object? type = null,Object? angle = freezed,Object? intensity = freezed,Object? dx = freezed,Object? dy = freezed,Object? scale = freezed,}) {
  return _then(_self.copyWith(
to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ControlSignalType,angle: freezed == angle ? _self.angle : angle // ignore: cast_nullable_to_non_nullable
as double?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double?,dx: freezed == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double?,dy: freezed == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double?,scale: freezed == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ControlSignalModel implements ControlSignalModel {
  const _ControlSignalModel({@JsonKey(name: 'to') required this.to, @JsonKey(name: 'type') required this.type, @JsonKey(name: 'angle') this.angle, @JsonKey(name: 'intensity') this.intensity, @JsonKey(name: 'dx') this.dx, @JsonKey(name: 'dy') this.dy, @JsonKey(name: 'scale') this.scale});
  factory _ControlSignalModel.fromJson(Map<String, dynamic> json) => _$ControlSignalModelFromJson(json);

@override@JsonKey(name: 'to') final  String to;
@override@JsonKey(name: 'type') final  ControlSignalType type;
@override@JsonKey(name: 'angle') final  double? angle;
@override@JsonKey(name: 'intensity') final  double? intensity;
@override@JsonKey(name: 'dx') final  double? dx;
@override@JsonKey(name: 'dy') final  double? dy;
@override@JsonKey(name: 'scale') final  double? scale;

/// Create a copy of ControlSignalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ControlSignalModelCopyWith<_ControlSignalModel> get copyWith => __$ControlSignalModelCopyWithImpl<_ControlSignalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ControlSignalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ControlSignalModel&&(identical(other.to, to) || other.to == to)&&(identical(other.type, type) || other.type == type)&&(identical(other.angle, angle) || other.angle == angle)&&(identical(other.intensity, intensity) || other.intensity == intensity)&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy)&&(identical(other.scale, scale) || other.scale == scale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,to,type,angle,intensity,dx,dy,scale);

@override
String toString() {
  return 'ControlSignalModel(to: $to, type: $type, angle: $angle, intensity: $intensity, dx: $dx, dy: $dy, scale: $scale)';
}


}

/// @nodoc
abstract mixin class _$ControlSignalModelCopyWith<$Res> implements $ControlSignalModelCopyWith<$Res> {
  factory _$ControlSignalModelCopyWith(_ControlSignalModel value, $Res Function(_ControlSignalModel) _then) = __$ControlSignalModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'to') String to,@JsonKey(name: 'type') ControlSignalType type,@JsonKey(name: 'angle') double? angle,@JsonKey(name: 'intensity') double? intensity,@JsonKey(name: 'dx') double? dx,@JsonKey(name: 'dy') double? dy,@JsonKey(name: 'scale') double? scale
});




}
/// @nodoc
class __$ControlSignalModelCopyWithImpl<$Res>
    implements _$ControlSignalModelCopyWith<$Res> {
  __$ControlSignalModelCopyWithImpl(this._self, this._then);

  final _ControlSignalModel _self;
  final $Res Function(_ControlSignalModel) _then;

/// Create a copy of ControlSignalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? to = null,Object? type = null,Object? angle = freezed,Object? intensity = freezed,Object? dx = freezed,Object? dy = freezed,Object? scale = freezed,}) {
  return _then(_ControlSignalModel(
to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ControlSignalType,angle: freezed == angle ? _self.angle : angle // ignore: cast_nullable_to_non_nullable
as double?,intensity: freezed == intensity ? _self.intensity : intensity // ignore: cast_nullable_to_non_nullable
as double?,dx: freezed == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double?,dy: freezed == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double?,scale: freezed == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on

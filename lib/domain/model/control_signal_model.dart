import 'package:freezed_annotation/freezed_annotation.dart';

part 'control_signal_model.freezed.dart';
part 'control_signal_model.g.dart';

enum ControlSignalType { joystick, drag, zoom }

@freezed
abstract class ControlSignalModel with _$ControlSignalModel {
  const factory ControlSignalModel({
    @JsonKey(name: 'to') required String to,
    @JsonKey(name: 'type') required ControlSignalType type,
    @JsonKey(name: 'angle') double? angle,
    @JsonKey(name: 'intensity') double? intensity,
    @JsonKey(name: 'dx') double? dx,
    @JsonKey(name: 'dy') double? dy,
    @JsonKey(name: 'scale') double? scale,
  }) = _ControlSignalModel;

  factory ControlSignalModel.fromJson(Map<String, dynamic> json) =>
      _$ControlSignalModelFromJson(json);
}

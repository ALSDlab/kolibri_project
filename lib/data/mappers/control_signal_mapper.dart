import 'package:kolibri_project/data/dtos/control_signal_dto.dart';
import 'package:kolibri_project/domain/model/control_signal_model.dart';

class ControlSignalMapper {
  static ControlSignalModel fromDTO(ControlSignalDto dto) {
    return ControlSignalModel(
      to: dto.to ?? '',
      type: (dto.type == 'joystick')
          ? ControlSignalType.joystick
          : (dto.type == 'drag')
          ? ControlSignalType.drag
          : ControlSignalType.zoom,
      angle: dto.angle ?? 0.0,
      intensity: dto.intensity ?? 0.0,
      dx: dto.dx ?? 0.0,
      dy: dto.dy ?? 0.0,
      scale: dto.scale ?? 0.0,
    );
  }

  static ControlSignalDto toDTO(ControlSignalModel model) {
    return ControlSignalDto(
      to: model.to,
      type: model.type.toString(),
      intensity: model.intensity,
      dx: model.dx,
      dy: model.dy,
      scale: model.scale,
    );
  }
}

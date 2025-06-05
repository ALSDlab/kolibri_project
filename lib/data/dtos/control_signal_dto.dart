
class ControlSignalDto {
  String? to; // 수신자 ID
  String? type;
  // Joystick data
  double? angle; // 각도 (라디안 또는 도)
  double? intensity; // 강도 (0.0 ~ 1.0)
  // Drag data
  double? dx;
  double? dy;
  // Zoom data
  double? scale;

  //<editor-fold desc="Data Methods">
  ControlSignalDto({
    this.to,
    this.type,
    this.angle,
    this.intensity,
    this.dx,
    this.dy,
    this.scale,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ControlSignalDto &&
          runtimeType == other.runtimeType &&
          to == other.to &&
          type == other.type &&
          angle == other.angle &&
          intensity == other.intensity &&
          dx == other.dx &&
          dy == other.dy &&
          scale == other.scale);

  @override
  int get hashCode =>
      to.hashCode ^
      type.hashCode ^
      angle.hashCode ^
      intensity.hashCode ^
      dx.hashCode ^
      dy.hashCode ^
      scale.hashCode;

  @override
  String toString() {
    return 'ControlSignalDto{ to: $to, type: $type, angle: $angle, intensity: $intensity, dx: $dx, dy: $dy, scale: $scale }';
  }

  ControlSignalDto copyWith({
    String? to,
    String? type,
    double? angle,
    double? intensity,
    double? dx,
    double? dy,
    double? scale,
  }) {
    return ControlSignalDto(
      to: to ?? this.to,
      type: type ?? this.type,
      angle: angle ?? this.angle,
      intensity: intensity ?? this.intensity,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      scale: scale ?? this.scale,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'to': to,
      'type': type,
      'angle': angle,
      'intensity': intensity,
      'dx': dx,
      'dy': dy,
      'scale': scale,
    };
  }

  factory ControlSignalDto.fromJson(Map<String, dynamic> map) {
    return ControlSignalDto(
      to: map['to'] as String,
      type: map['type'] as String,
      angle: map['angle'] as double,
      intensity: map['intensity'] as double,
      dx: map['dx'] as double,
      dy: map['dy'] as double,
      scale: map['scale'] as double,
    );
  }

  //</editor-fold>
}

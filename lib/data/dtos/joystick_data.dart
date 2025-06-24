class JoystickData {
  double? dx;
  double? dy;

  //<editor-fold desc="Data Methods">
  JoystickData({this.dx, this.dy});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JoystickData &&
          runtimeType == other.runtimeType &&
          dx == other.dx &&
          dy == other.dy);

  @override
  int get hashCode => dx.hashCode ^ dy.hashCode;

  @override
  String toString() {
    return 'JoystickData{ dx: $dx, dy: $dy }';
  }

  JoystickData copyWith({double? dx, double? dy}) {
    return JoystickData(dx: dx ?? this.dx, dy: dy ?? this.dy);
  }

  Map<String, dynamic> toJson() {
    return {'dx': dx, 'dy': dy};
  }

  factory JoystickData.fromJson(Map<String, dynamic> map) {
    return JoystickData(
      dx: (map['dx'] as num?)?.toDouble(),
      dy: (map['dy'] as num?)?.toDouble(),
    );
  }

  //</editor-fold>
}

class GestureData {
  double? scale;
  double? dx;
  double? dy;

  //<editor-fold desc="Data Methods">
  GestureData({this.scale, this.dx, this.dy});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GestureData &&
          runtimeType == other.runtimeType &&
          scale == other.scale &&
          dx == other.dx &&
          dy == other.dy);

  @override
  int get hashCode => scale.hashCode ^ dx.hashCode ^ dy.hashCode;

  @override
  String toString() {
    return 'GestureData{ scale: $scale, dx: $dx, dy: $dy }';
  }

  GestureData copyWith({double? scale, double? dx, double? dy}) {
    return GestureData(
      scale: scale ?? this.scale,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }

  Map<String, dynamic> toJson() {
    return {'scale': scale, 'dx': dx, 'dy': dy};
  }

  factory GestureData.fromJson(Map<String, dynamic> map) {
    return GestureData(
      scale: map['scale'] as double,
      dx: (map['dx'] as num?)?.toDouble(),
      dy: (map['dy'] as num?)?.toDouble(),
    );
  }

  //</editor-fold>
}

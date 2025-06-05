class IceCandidateDto {
  String? candidate;
  String? sdpMid;
  int? sdpMLineIndex;
  String? to;
  String? from;

  //<editor-fold desc="Data Methods">
  IceCandidateDto({
    this.candidate,
    this.sdpMid,
    this.sdpMLineIndex,
    this.to,
    this.from,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IceCandidateDto &&
          runtimeType == other.runtimeType &&
          candidate == other.candidate &&
          sdpMid == other.sdpMid &&
          sdpMLineIndex == other.sdpMLineIndex &&
          to == other.to &&
          from == other.from);

  @override
  int get hashCode =>
      candidate.hashCode ^
      sdpMid.hashCode ^
      sdpMLineIndex.hashCode ^
      to.hashCode ^
      from.hashCode;

  @override
  String toString() {
    return 'IceCandidateDto{ candidate: $candidate, sdpMid: $sdpMid, sdpMLineIndex: $sdpMLineIndex, to: $to, from: $from }';
  }

  IceCandidateDto copyWith({
    String? candidate,
    String? sdpMid,
    int? sdpMLineIndex,
    String? to,
    String? from,
  }) {
    return IceCandidateDto(
      candidate: candidate ?? this.candidate,
      sdpMid: sdpMid ?? this.sdpMid,
      sdpMLineIndex: sdpMLineIndex ?? this.sdpMLineIndex,
      to: to ?? this.to,
      from: from ?? this.from,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidate': candidate,
      'sdpMid': sdpMid,
      'sdpMLineIndex': sdpMLineIndex,
      'to': to,
      'from': from,
    };
  }

  factory IceCandidateDto.fromJson(Map<String, dynamic> map) {
    return IceCandidateDto(
      candidate: map['candidate'] as String,
      sdpMid: map['sdpMid'] as String,
      sdpMLineIndex: map['sdpMLineIndex'] as int,
      to: map['to'] as String,
      from: map['from'] as String,
    );
  }

  //</editor-fold>
}

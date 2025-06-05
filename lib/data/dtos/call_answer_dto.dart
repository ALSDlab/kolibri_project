class CallAnswerDto {
  String? fromId;
  String? toId;
  String? sdp;
  String? type;
  bool? audioOnly;

  //<editor-fold desc="Data Methods">
  CallAnswerDto({this.fromId, this.toId, this.sdp, this.type, this.audioOnly});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallAnswerDto &&
          runtimeType == other.runtimeType &&
          fromId == other.fromId &&
          toId == other.toId &&
          sdp == other.sdp &&
          type == other.type &&
          audioOnly == other.audioOnly);

  @override
  int get hashCode =>
      fromId.hashCode ^
      toId.hashCode ^
      sdp.hashCode ^
      type.hashCode ^
      audioOnly.hashCode;

  @override
  String toString() {
    return 'CallAnswerDto{ fromId: $fromId, toId: $toId, sdp: $sdp, type: $type, audioOnly: $audioOnly }';
  }

  CallAnswerDto copyWith({
    String? fromId,
    String? toId,
    String? sdp,
    String? type,
    bool? audioOnly,
  }) {
    return CallAnswerDto(
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      sdp: sdp ?? this.sdp,
      type: type ?? this.type,
      audioOnly: audioOnly ?? this.audioOnly,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromId': fromId,
      'toId': toId,
      'sdp': sdp,
      'type': type,
      'audioOnly': audioOnly,
    };
  }

  factory CallAnswerDto.fromJson(Map<String, dynamic> map) {
    return CallAnswerDto(
      fromId: map['fromId'] as String,
      toId: map['toId'] as String,
      sdp: map['sdp'] as String,
      type: map['type'] as String,
      audioOnly: map['audioOnly'] as bool,
    );
  }

  //</editor-fold>
}

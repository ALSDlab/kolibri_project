class PeerUserDto {
  String? id;
  String? name;
  String? imageUrl;
  String? thumbnailUrl;

  //<editor-fold desc="Data Methods">
  PeerUserDto({this.id, this.name, this.imageUrl, this.thumbnailUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeerUserDto &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          imageUrl == other.imageUrl &&
          thumbnailUrl == other.thumbnailUrl);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ imageUrl.hashCode ^ thumbnailUrl.hashCode;

  @override
  String toString() {
    return 'PeerUserDto{ id: $id, name: $name, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl }';
  }

  PeerUserDto copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? thumbnailUrl,
  }) {
    return PeerUserDto(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory PeerUserDto.fromJson(Map<String, dynamic> map) {
    return PeerUserDto(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
    );
  }

  //</editor-fold>
}

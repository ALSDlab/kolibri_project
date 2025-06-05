import 'package:kolibri_project/data/dtos/peer_user_dto.dart';
import 'package:kolibri_project/domain/model/peer_user_model.dart';

class PeerUserMapper {
  static PeerUserModel fromDTO(PeerUserDto dto) {
    return PeerUserModel(
      id: dto.id ?? '',
      name: dto.name ?? '',
      imageUrl: dto.imageUrl ?? '',
      thumbnailUrl: dto.thumbnailUrl ?? '',
    );
  }

  static PeerUserDto toDTO(PeerUserModel model) {
    return PeerUserDto(
      id: model.id,
      name: model.name,
      imageUrl: model.imageUrl,
      thumbnailUrl: model.thumbnailUrl,
    );
  }
}

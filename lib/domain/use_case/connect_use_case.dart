import 'package:kolibri_project/domain/repository/video_call_repository.dart';

import '../../data/core/result.dart';

class ConnectUseCase {
  final VideoCallRepository _repository;

  ConnectUseCase(this._repository);

  Future<Result<void>> call(String roomId) {
    return _repository.connect(roomId);
  }
}

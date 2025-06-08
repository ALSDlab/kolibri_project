// domain/use_case/webrtc/signaling/connect_signaling_use_case.dart
import 'dart:async';

import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class ConnectSignalingUseCase {
  final WebRTCRepository _repository;

  ConnectSignalingUseCase(this._repository);

  Stream<Result<String>> call(String url) {
    return _repository.connectSignaling(url);
  }
}

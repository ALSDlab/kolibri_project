// domain/use_case/webrtc/signaling/listen_for_control_signal_use_case.dart
import 'dart:async';

import '../../../model/control_signal_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenForControlSignalUseCase {
  final WebRTCRepository _repository;

  ListenForControlSignalUseCase(this._repository);

  Stream<ControlSignalModel> call() {
    return _repository.listenForControlSignal();
  }
}

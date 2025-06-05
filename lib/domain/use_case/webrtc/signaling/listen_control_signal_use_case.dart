import 'dart:async';

import '../../../model/control_signal_model.dart';
import '../../../repository/webrtc_repository.dart';

class ListenControlSignalUseCase {
  final WebrtcRepository _repository;

  ListenControlSignalUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Stream<ControlSignalModel> call() => _repository.getControlSignalStream();
}

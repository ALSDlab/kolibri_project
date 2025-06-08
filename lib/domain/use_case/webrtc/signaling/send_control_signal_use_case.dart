// domain/use_case/webrtc/signaling/send_control_signal_use_case.dart
import '../../../model/control_signal_model.dart';
import '../../../repository/webrtc_repository.dart';

class SendControlSignalUseCase {
  final WebRTCRepository _repository;

  SendControlSignalUseCase(this._repository);

  void call(ControlSignalModel signal) {
    _repository.sendControlSignal(signal);
  }
}

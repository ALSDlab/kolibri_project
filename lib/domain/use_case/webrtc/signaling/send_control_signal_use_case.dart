import '../../../../data/core/result.dart';
import '../../../model/control_signal_model.dart';
import '../../../repository/webrtc_repository.dart';

class SendControlSignalUseCase {
  final WebrtcRepository _repository;

  SendControlSignalUseCase({required WebrtcRepository chatDataRepository})
    : _repository = chatDataRepository;

  Future<Result<void>> call(ControlSignalModel signal) =>
      _repository.sendControlSignal(signal);
}

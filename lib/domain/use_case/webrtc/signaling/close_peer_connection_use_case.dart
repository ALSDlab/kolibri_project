import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart'; // Assuming your Result class is here

import '../../../repository/webrtc_repository.dart';

class ClosePeerConnectionUseCase {
  final WebRTCRepository _webrtcRepository;

  ClosePeerConnectionUseCase(this._webrtcRepository);

  // Consider passing localStream and localRenderer here if they are managed externally
  Future<Result<void>> call(
    RTCPeerConnection? peerConnection,
    MediaStream? localStream,
    RTCVideoRenderer? localRenderer,
  ) async {
    try {
      if (localStream != null && localRenderer != null) {
        try {
          await _webrtcRepository.turnOffMediaStream(
            localStream,
            localRenderer,
          );
          return const Success(null);
        } catch (e) {
          return Error(e.toString());
        }
      }

      // Dispose of the peer connection using the repository
      await _webrtcRepository.disposePeerConnection(peerConnection);

      return const Success(null); // Indicate success
    } catch (e) {
      return Error('Failed to close peer connection: $e');
    }
  }
}

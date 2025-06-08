// domain/use_case/webrtc/media_peer_connection/create_sdp_offer_use_case.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';

import '../../../repository/webrtc_repository.dart';

class CreateSdpOfferUseCase {
  final WebRTCRepository _repository;

  CreateSdpOfferUseCase(this._repository);

  Future<Result<RTCSessionDescription>> call(
    RTCPeerConnection peerConnection,
  ) async {
    try {
      final sdp = await _repository.createSdpOffer(peerConnection);
      return Success(sdp);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

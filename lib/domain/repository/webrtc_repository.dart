import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../data/core/result.dart';
import '../model/call_answer_model.dart';
import '../model/call_offer_model.dart';
import '../model/control_signal_model.dart';
import '../model/ice_candidate_info_model.dart';
import '../model/peer_user_model.dart';

abstract class WebrtcRepository {
  // Signaling Connection
  Future<Result<String>> connectSignaling(String serverUrl);

  Future<void> disconnectSignaling();

  Stream<List<PeerUserModel>> getOnlineUsersStream(); // Stream of user lists
  Stream<CallOfferModel> getOfferStream();

  Stream<CallAnswerModel> getAnswerStream();

  Stream<IceCandidateInfoModel> getIceCandidateStream();

  Stream<String> getHangUpStream(); // Emits ID of user who hung up
  Stream<String> getRefusalStream(); // Emits ID of user who refused
  Stream<ControlSignalModel> getControlSignalStream(); // Domain model

  // Signaling Actions
  Future<Result<void>> sendOffer(CallOfferModel offer);

  Future<Result<void>> sendAnswer(CallAnswerModel answer);

  Future<Result<void>> sendIceCandidate(IceCandidateInfoModel candidate);

  Future<Result<void>> sendRefusal({
    required String toId,
    required String fromId,
  });

  Future<Result<void>> sendHangUp({
    required String toId,
    required String fromId,
  });

  Future<Result<void>> sendControlSignal(
    ControlSignalModel controlSignal,
  ); // Domain model

  // WebRTC Media & Peer Connection
  Future<void> initializeRenderers();

  RTCVideoRenderer get localRenderer;

  RTCVideoRenderer get remoteRenderer;

  Future<Result<MediaStream?>> getLocalUserMedia({required bool audioOnly});

  Future<void> turnOffLocalMedia(MediaStream? stream);

  Future<Result<RTCPeerConnection>> createPeerConnection();

  Future<void> addTrackToPeer(
    MediaStream stream,
    RTCPeerConnection peerConnection,
  );

  Future<void> setLocalDescription(
    RTCSessionDescription description,
    RTCPeerConnection peerConnection,
  );

  Future<void> setRemoteDescription(
    RTCSessionDescription description,
    RTCPeerConnection peerConnection,
  );

  Future<void> addIceCandidateToPeer(
    RTCIceCandidate candidate,
    RTCPeerConnection peerConnection,
  );

  Future<void> disposePeerConnection(RTCPeerConnection? peerConnection);

  Stream<MediaStream> getOnTrackStream(RTCPeerConnection peerConnection);

  Stream<RTCIceCandidate> getOnIceCandidateStream(
    RTCPeerConnection peerConnection,
  );

  Stream<RTCPeerConnectionState> getOnConnectionStateStream(
    RTCPeerConnection peerConnection,
  );

  Future<RTCSessionDescription> createSdpOffer(
    RTCPeerConnection peerConnection, {
    required bool audioOnly,
  });

  Future<RTCSessionDescription> createSdpAnswer(
    RTCPeerConnection peerConnection, {
    required bool audioOnly,
  });

  void disposeRenderers();
}

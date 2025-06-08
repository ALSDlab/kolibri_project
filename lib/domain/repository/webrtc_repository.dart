// domain/repository/webrtc_repository.dart
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';
import '../model/call_answer_model.dart';
import '../model/call_offer_model.dart';
import '../model/control_signal_model.dart';
import '../model/ice_candidate_info_model.dart';
import '../model/peer_user_model.dart';

abstract class WebRTCRepository {
  // Signaling related methods
  Stream<Result<String>> connectSignaling(String url);
  void disconnectSignaling(); // Added if not present
  void callPeer(CallOfferModel offer);
  void acceptIncomingCall(CallAnswerModel answer);
  void declineIncomingCall(String toUserId);
  void hangUpCall(String toUserId, String fromUserId);
  void sendIceCandidate(IceCandidateInfoModel candidate);
  void sendControlSignal(ControlSignalModel signal);

  // Listening streams
  Stream<List<PeerUserModel>> listenForUserList();
  Stream<CallOfferModel> listenForCallOffers();
  Stream<CallAnswerModel> listenForCallAnswer();
  Stream<IceCandidateInfoModel> listenForIceCandidates();
  Stream<String> listenForRefusedCall();
  Stream<ControlSignalModel> listenForControlSignal();
  Stream<MediaStream> getOnTrackStream(RTCPeerConnection peerConnection, RTCVideoRenderer remoteRenderer);
  Stream<RTCIceCandidate> getOnIceCandidateStream(RTCPeerConnection peerConnection);
  Stream<RTCPeerConnectionState> getOnConnectionStateStream(RTCPeerConnection peerConnection);
  Stream<String> getOnHangUpStream();



  // WebRTC media and peer connection methods
  Future<Result<RTCPeerConnection>> createPeerConnection();
  Future<Result<MediaStream>> turnOnLocalMediaStream({required bool audioOnly, required RTCVideoRenderer localRenderer});
  Future<void> turnOffMediaStream(MediaStream? stream, RTCVideoRenderer localRenderer);
  Future<void> addTrackToPeerConnection(MediaStream stream, RTCPeerConnection peerConnection);
  Future<RTCSessionDescription> createSdpOffer(RTCPeerConnection peerConnection);
  Future<RTCSessionDescription> createSdpAnswer(RTCPeerConnection peerConnection);
  Future<void> settingLocalDescription(RTCPeerConnection peerConnection, RTCSessionDescription description);
  Future<void> settingRemoteDescription(RTCPeerConnection peerConnection, RTCSessionDescription description);
  Future<void> addingIceCandidate(RTCIceCandidate candidate, RTCPeerConnection peerConnection);
  Future<void> disposePeerConnection(RTCPeerConnection? peerConnection);
}
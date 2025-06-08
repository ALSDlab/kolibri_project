import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/dtos/peer_user_dto.dart';
import 'package:kolibri_project/data/mappers/call_answer_mapper.dart';
import 'package:kolibri_project/data/mappers/call_offer_mapper.dart';
import 'package:kolibri_project/data/mappers/control_signal_mapper.dart';
import 'package:kolibri_project/data/mappers/ice_candidate_mapper.dart';
import 'package:kolibri_project/data/mappers/peer_user_mapper.dart';

import '../../domain/model/call_answer_model.dart';
import '../../domain/model/call_offer_model.dart';
import '../../domain/model/control_signal_model.dart';
import '../../domain/model/ice_candidate_info_model.dart';
import '../../domain/model/peer_user_model.dart';
import '../../domain/repository/webrtc_repository.dart';
import '../core/result.dart';
import '../data_source/remote/socket_data_source.dart';
import '../data_source/remote/webrtc_data_source.dart';

class WebRTCRepositoryImpl implements WebRTCRepository {
  final SocketDataSource _socketDataSource;
  final WebRTCDataSource _webRTCDataSource;

  WebRTCRepositoryImpl(this._socketDataSource, this._webRTCDataSource);

  @override
  Stream<Result<String>> connectSignaling(String url) async* {
    try {
      final userId = await _socketDataSource.connect(url);
      yield Success(userId);
    } catch (e) {
      yield Error(e.toString());
    }
  }

  @override
  void disconnectSignaling() {
    _socketDataSource.dispose();
  }

  @override
  void callPeer(CallOfferModel offer) {
    _socketDataSource.sendOffer(CallOfferMapper.toDTO(offer));
  }

  @override
  void acceptIncomingCall(CallAnswerModel answer) {
    _socketDataSource.sendAnswer(CallAnswerMapper.toDTO(answer));
  }

  @override
  void declineIncomingCall(String toUserId) {
    _socketDataSource.emit('refuse', {'to': toUserId});
  }

  @override
  void hangUpCall(String toUserId, String fromUserId) {
    _socketDataSource.emit('disconnect', {'to': toUserId, 'from': fromUserId});
  }

  @override
  Stream<List<PeerUserModel>> listenForUserList() {
    return _socketDataSource.userListStream.map((userListDto) {
      return userListDto
          .where((id) => id != _socketDataSource.currentUserId) // Filter out self
          .map((id) => PeerUserMapper.fromDTO(PeerUserDto(id: id)))
          .toList();
    });
  }

  @override
  Stream<CallOfferModel> listenForCallOffers() {
    return _socketDataSource.offerStream.map((offerDto) => CallOfferMapper.fromDTO(offerDto));
  }

  @override
  Stream<CallAnswerModel> listenForCallAnswer() {
    return _socketDataSource.answerStream.map((answerDto) => CallAnswerMapper.fromDTO(answerDto));
  }

  @override
  Stream<IceCandidateInfoModel> listenForIceCandidates() {
    return _socketDataSource.iceCandidateStream
        .map((candidateDto) => IceCandidateMapper.fromDTO(candidateDto));
  }

  @override
  Stream<String> listenForRefusedCall() {
    return _socketDataSource.refusalStream;
  }

  @override
  Stream<ControlSignalModel> listenForControlSignal() {
    return _socketDataSource.controlSignalStream
        .map((dto) => ControlSignalMapper.fromDTO(dto));
  }


  @override
  void sendIceCandidate(IceCandidateInfoModel candidate) {
    _socketDataSource.emit('iceCandidate', IceCandidateMapper.toDTO(candidate).toJson());
  }

  @override
  void sendControlSignal(ControlSignalModel signal) {
    _socketDataSource.emit('controlSignal', ControlSignalMapper.toDTO(signal).toJson());
  }

  @override
  Future<Result<RTCPeerConnection>> createPeerConnection() async {
    try {
      final pc = await _webRTCDataSource.initializePeerConnection();
      return Success(pc);
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<MediaStream>> turnOnLocalMediaStream(
      {required bool audioOnly, required RTCVideoRenderer localRenderer}) async {
    try {
      final stream = await _webRTCDataSource.gettingUserMedia(audioOnly: audioOnly, localRenderer: localRenderer);
      if (stream != null) {
        return Success(stream);
      } else {
        return Error("Failed to get local media stream.");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<void> turnOffMediaStream(MediaStream? stream, RTCVideoRenderer localRenderer) async {
    await _webRTCDataSource.turnOffMediaStream(stream, localRenderer);
  }

  @override
  Future<void> addTrackToPeerConnection(MediaStream stream, RTCPeerConnection peerConnection) async {
    await _webRTCDataSource.addTrackToExistingPeerConnection(stream, peerConnection);
  }

  @override
  Future<RTCSessionDescription> createSdpOffer(RTCPeerConnection peerConnection) async {
    return await _webRTCDataSource.createSdpOffer(peerConnection);
  }

  @override
  Future<RTCSessionDescription> createSdpAnswer(RTCPeerConnection peerConnection) async {
    return await _webRTCDataSource.createSdpAnswer(peerConnection);
  }

  @override
  Future<void> settingLocalDescription(
      RTCPeerConnection peerConnection, RTCSessionDescription description) async {
    await _webRTCDataSource.setLocalDescription(peerConnection, description);
  }

  @override
  Future<void> settingRemoteDescription(
      RTCPeerConnection peerConnection, RTCSessionDescription description) async {
    await _webRTCDataSource.setRemoteDescription(peerConnection, description);
  }

  @override
  Future<void> addingIceCandidate(RTCIceCandidate candidate, RTCPeerConnection peerConnection) async {
    await _webRTCDataSource.appendIceCandidate(candidate, peerConnection);
  }

  @override
  Stream<MediaStream> getOnTrackStream(RTCPeerConnection peerConnection, RTCVideoRenderer remoteRenderer) {
    return _webRTCDataSource.onTrackStream(peerConnection, remoteRenderer);
  }

  @override
  Stream<RTCIceCandidate> getOnIceCandidateStream(RTCPeerConnection peerConnection) {
    return _webRTCDataSource.onIceCandidateGeneratedStream(peerConnection);
  }

  @override
  Stream<RTCPeerConnectionState> getOnConnectionStateStream(RTCPeerConnection peerConnection) {
    return _webRTCDataSource.onConnectionStateChangeStream(peerConnection);
  }

  @override
  Future<void> disposePeerConnection(RTCPeerConnection? peerConnection) async {
    if (peerConnection != null) {
      await peerConnection.close();
      await peerConnection.dispose();
    }
  }

  @override
  Stream<String> getOnHangUpStream() {
    return _socketDataSource.hangUpStream;
  }
}
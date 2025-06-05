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

class WebRTCRepositoryImpl implements WebrtcRepository {
  final SocketDataSource _socketDataSource;
  final WebRTCDataSource _webRTCDataSource;

  WebRTCRepositoryImpl(this._socketDataSource, this._webRTCDataSource);

  @override
  Future<Result<String>> connectSignaling(String serverUrl) async {
    try {
      final userId = await _socketDataSource.connect(serverUrl);
      if (userId != null) {
        return Result.success(userId);
      }
      return const Result.error("Failed to connect or get user ID");
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<void> disconnectSignaling() async {
    _socketDataSource.dispose();
  }

  @override
  Stream<List<PeerUserModel>> getOnlineUsersStream() {
    return _socketDataSource.userListStream.map((ids) {
      return ids
          .map((id) => PeerUserMapper.fromDTO(PeerUserDto(id: id)))
          .toList();
    });
  }

  @override
  Stream<CallOfferModel> getOfferStream() {
    return _socketDataSource.offerStream.map(CallOfferMapper.fromDTO);
  }

  @override
  Stream<CallAnswerModel> getAnswerStream() {
    return _socketDataSource.answerStream.map(CallAnswerMapper.fromDTO);
  }

  @override
  Stream<IceCandidateInfoModel> getIceCandidateStream() {
    return _socketDataSource.iceCandidateStream.map(IceCandidateMapper.fromDTO);
  }

  @override
  Stream<String> getHangUpStream() => _socketDataSource.hangUpStream;

  @override
  Stream<String> getRefusalStream() => _socketDataSource.refusalStream;

  @override
  Stream<ControlSignalModel> getControlSignalStream() {
    return _socketDataSource.controlSignalStream.map(
      ControlSignalMapper.fromDTO,
    );
  }

  @override
  Future<Result<void>> sendOffer(CallOfferModel offer) async {
    try {
      _socketDataSource.emit('offer', CallOfferMapper.toDTO(offer).toJson());
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> sendAnswer(CallAnswerModel answer) async {
    try {
      _socketDataSource.emit('answer', CallAnswerMapper.toDTO(answer).toJson());
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> sendIceCandidate(IceCandidateInfoModel candidate) async {
    try {
      _socketDataSource.emit(
        'iceCandidate',
        IceCandidateMapper.toDTO(candidate).toJson(),
      );
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> sendRefusal({
    required String toId,
    required String fromId,
  }) async {
    try {
      _socketDataSource.emit('refuse', {'to': toId, 'from': fromId});
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> sendHangUp({
    required String toId,
    required String fromId,
  }) async {
    try {
      _socketDataSource.emit('disconnectPeer', {'to': toId, 'from': fromId});
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<void>> sendControlSignal(
    ControlSignalModel controlSignal,
  ) async {
    try {
      _socketDataSource.emit(
        'controlSignal',
        ControlSignalMapper.toDTO(controlSignal).toJson(),
      );
      return const Result.success(null);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  // WebRTC Media & Peer Connection Implementations
  @override
  Future<void> initializeRenderers() => _webRTCDataSource.initializeRenderers();

  @override
  RTCVideoRenderer get localRenderer => _webRTCDataSource.localRenderer;

  @override
  RTCVideoRenderer get remoteRenderer => _webRTCDataSource.remoteRenderer;

  @override
  Future<Result<MediaStream?>> getLocalUserMedia({
    required bool audioOnly,
  }) async {
    try {
      final stream = await _webRTCDataSource.getUserMedia(audioOnly: audioOnly);
      if (stream != null) return Result.success(stream);
      return const Result.error("Failed to get user media");
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<void> turnOffLocalMedia(MediaStream? stream) =>
      _webRTCDataSource.turnOffMediaStream(stream);

  @override
  Future<Result<RTCPeerConnection>> createPeerConnection() async {
    try {
      return Result.success(await _webRTCDataSource.createPc());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<void> addTrackToPeer(
    MediaStream stream,
    RTCPeerConnection peerConnection,
  ) async {
    await _webRTCDataSource.addTrackToExistingPeerConnection(
      stream,
      peerConnection,
    );
  }

  @override
  Future<void> setLocalDescription(
    RTCSessionDescription description,
    RTCPeerConnection peerConnection,
  ) async {
    await peerConnection.setLocalDescription(description);
  }

  @override
  Future<void> setRemoteDescription(
    RTCSessionDescription description,
    RTCPeerConnection peerConnection,
  ) async {
    await peerConnection.setRemoteDescription(description);
  }

  @override
  Future<void> addIceCandidateToPeer(
    RTCIceCandidate candidate,
    RTCPeerConnection peerConnection,
  ) async {
    await peerConnection.addCandidate(candidate);
  }

  @override
  Stream<MediaStream> getOnTrackStream(RTCPeerConnection peerConnection) =>
      _webRTCDataSource.onTrackStream(peerConnection);

  @override
  Stream<RTCIceCandidate> getOnIceCandidateStream(
    RTCPeerConnection peerConnection,
  ) => _webRTCDataSource.onIceCandidateGeneratedStream(peerConnection);

  @override
  Stream<RTCPeerConnectionState> getOnConnectionStateStream(
    RTCPeerConnection peerConnection,
  ) => _webRTCDataSource.onConnectionStateChangeStream(peerConnection);

  @override
  Future<RTCSessionDescription> createSdpOffer(
    RTCPeerConnection peerConnection, {
    required bool audioOnly,
  }) async {
    return await peerConnection.createOffer({
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': !audioOnly,
      },
    });
  }

  @override
  Future<RTCSessionDescription> createSdpAnswer(
    RTCPeerConnection peerConnection, {
    required bool audioOnly,
  }) async {
    return await peerConnection.createAnswer({
      'mandatory': {
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': !audioOnly,
      },
    });
  }

  @override
  Future<void> disposePeerConnection(RTCPeerConnection? peerConnection) async {
    await peerConnection?.close();
    // Also potentially clear local/remote renderer srcObject
    _webRTCDataSource.localRenderer.srcObject = null;
    _webRTCDataSource.remoteRenderer.srcObject = null;
  }

  @override
  void disposeRenderers() {
    _webRTCDataSource.disposeAllRenderers();
  }
}

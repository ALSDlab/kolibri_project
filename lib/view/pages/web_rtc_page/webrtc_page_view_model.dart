import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';
import 'package:kolibri_project/env/env.dart';
import 'package:kolibri_project/view/pages/web_rtc_page/webrtc_page_state.dart';
import 'package:vibration/vibration.dart';

import '../../../domain/model/call_answer_model.dart';
import '../../../domain/model/call_offer_model.dart';
import '../../../domain/model/control_signal_model.dart' as domain_cs;
import '../../../domain/model/ice_candidate_info_model.dart';
import '../../../domain/model/peer_user_model.dart';
import '../../../domain/repository/webrtc_repository.dart';
// Import ALL your use cases here...
import '../../../domain/use_case/webrtc/media_peer_connection/add_ice_candidate_to_peer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/add_track_to_peer_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/connect_signaling_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/create_peer_connection_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/create_sdp_answer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/create_sdp_offer_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/disconnect_signaling_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/dispose_peer_connection_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/dispose_renderers_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/get_local_user_media_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/get_user_list_stream_usecase.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/initialize_renderers_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_answer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/listen_connection_state_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_control_signal_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_hang_up_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_ice_candidate_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_offer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/listen_on_ice_candidate_generated_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/listen_on_track_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_refusal_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/send_answer_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/send_control_signal_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/send_hang_up_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/send_ice_candidate_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/send_offer_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/send_refusal_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/set_local_description_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/set_remote_description_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/turn_off_local_media_use_case.dart';

class WebRTCViewModel extends ChangeNotifier {
  // Use Cases
  final ConnectSignalingUseCase _connectSignalingUseCase;
  final DisconnectSignalingUseCase _disconnectSignalingUseCase;
  final GetUserListStreamUseCase _getUserListStreamUseCase;
  final SendOfferUseCase _sendOfferUseCase;
  final ListenOfferUseCase _listenOfferUseCase;
  final SendAnswerUseCase _sendAnswerUseCase;
  final ListenAnswerUseCase _listenAnswerUseCase;
  final SendIceCandidateUseCase _sendIceCandidateUseCase;
  final ListenIceCandidateUseCase _listenIceCandidateUseCase;
  final SendRefusalUseCase _sendRefusalUseCase;
  final ListenRefusalUseCase _listenRefusalUseCase;
  final SendHangUpUseCase _sendHangUpUseCase;
  final ListenHangUpUseCase _listenHangUpUseCase;
  final SendControlSignalUseCase _sendControlSignalUseCase;
  final ListenControlSignalUseCase _listenControlSignalUseCase;
  final InitializeRenderersUseCase _initializeRenderersUseCase;
  final GetLocalUserMediaUseCase _getLocalUserMediaUseCase;
  final TurnOffLocalMediaUseCase _turnOffLocalMediaUseCase;
  final CreatePeerConnectionUseCase _createPeerConnectionUseCase;
  final AddTrackToPeerUseCase _addTrackToPeerUseCase;
  final SetLocalDescriptionUseCase _setLocalDescriptionUseCase;
  final SetRemoteDescriptionUseCase _setRemoteDescriptionUseCase;
  final AddIceCandidateToPeerUseCase _addIceCandidateToPeerUseCase;
  final DisposePeerConnectionUseCase _disposePeerConnectionUseCase;
  final ListenOnTrackUseCase _listenOnTrackUseCase;
  final ListenOnIceCandidateGeneratedUseCase
  _listenOnIceCandidateGeneratedUseCase;
  final ListenConnectionStateUseCase _listenConnectionStateUseCase;
  final CreateSdpOfferUseCase _createSdpOfferUseCase;
  final CreateSdpAnswerUseCase _createSdpAnswerUseCase;
  final DisposeRenderersUseCase _disposeRenderersUseCase;

  final WebrtcRepository
  _webRTCRepository; // Still needed for direct renderer access

  WebrtcPageState _state = const WebrtcPageState();

  WebrtcPageState get state => _state;

  final List<StreamSubscription> _subscriptions = [];
  BuildContext? _callViewContext;
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;

  // IMPORTANT: Replace with your actual server IP and port
  final String _serverUrl = Env.kolibriServerAddress;

  WebRTCViewModel(
    this._webRTCRepository, {
    required ConnectSignalingUseCase connectSignalingUseCase,
    required DisconnectSignalingUseCase disconnectSignalingUseCase,
    required GetUserListStreamUseCase getUserListStreamUseCase,
    required SendOfferUseCase sendOfferUseCase,
    required ListenOfferUseCase listenOfferUseCase,
    required SendAnswerUseCase sendAnswerUseCase,
    required ListenAnswerUseCase listenAnswerUseCase,
    required SendIceCandidateUseCase sendIceCandidateUseCase,
    required ListenIceCandidateUseCase listenIceCandidateUseCase,
    required SendRefusalUseCase sendRefusalUseCase,
    required ListenRefusalUseCase listenRefusalUseCase,
    required SendHangUpUseCase sendHangUpUseCase,
    required ListenHangUpUseCase listenHangUpUseCase,
    required SendControlSignalUseCase sendControlSignalUseCase,
    required ListenControlSignalUseCase listenControlSignalUseCase,
    required InitializeRenderersUseCase initializeRenderersUseCase,
    required GetLocalUserMediaUseCase getLocalUserMediaUseCase,
    required TurnOffLocalMediaUseCase turnOffLocalMediaUseCase,
    required CreatePeerConnectionUseCase createPeerConnectionUseCase,
    required AddTrackToPeerUseCase addTrackToPeerUseCase,
    required SetLocalDescriptionUseCase setLocalDescriptionUseCase,
    required SetRemoteDescriptionUseCase setRemoteDescriptionUseCase,
    required AddIceCandidateToPeerUseCase addIceCandidateToPeerUseCase,
    required DisposePeerConnectionUseCase disposePeerConnectionUseCase,
    required ListenOnTrackUseCase listenOnTrackUseCase,
    required ListenOnIceCandidateGeneratedUseCase
    listenOnIceCandidateGeneratedUseCase,
    required ListenConnectionStateUseCase listenConnectionStateUseCase,
    required CreateSdpOfferUseCase createSdpOfferUseCase,
    required CreateSdpAnswerUseCase createSdpAnswerUseCase,
    required DisposeRenderersUseCase disposeRenderersUseCase,
  }) : _connectSignalingUseCase = connectSignalingUseCase,
       _disconnectSignalingUseCase = disconnectSignalingUseCase,
       _getUserListStreamUseCase = getUserListStreamUseCase,
       _sendOfferUseCase = sendOfferUseCase,
       _listenOfferUseCase = listenOfferUseCase,
       _sendAnswerUseCase = sendAnswerUseCase,
       _listenAnswerUseCase = listenAnswerUseCase,
       _sendIceCandidateUseCase = sendIceCandidateUseCase,
       _listenIceCandidateUseCase = listenIceCandidateUseCase,
       _sendRefusalUseCase = sendRefusalUseCase,
       _listenRefusalUseCase = listenRefusalUseCase,
       _sendHangUpUseCase = sendHangUpUseCase,
       _listenHangUpUseCase = listenHangUpUseCase,
       _sendControlSignalUseCase = sendControlSignalUseCase,
       _listenControlSignalUseCase = listenControlSignalUseCase,
       _initializeRenderersUseCase = initializeRenderersUseCase,
       _getLocalUserMediaUseCase = getLocalUserMediaUseCase,
       _turnOffLocalMediaUseCase = turnOffLocalMediaUseCase,
       _createPeerConnectionUseCase = createPeerConnectionUseCase,
       _addTrackToPeerUseCase = addTrackToPeerUseCase,
       _setLocalDescriptionUseCase = setLocalDescriptionUseCase,
       _setRemoteDescriptionUseCase = setRemoteDescriptionUseCase,
       _addIceCandidateToPeerUseCase = addIceCandidateToPeerUseCase,
       _disposePeerConnectionUseCase = disposePeerConnectionUseCase,
       _listenOnTrackUseCase = listenOnTrackUseCase,
       _listenOnIceCandidateGeneratedUseCase =
           listenOnIceCandidateGeneratedUseCase,
       _listenConnectionStateUseCase = listenConnectionStateUseCase,
       _createSdpOfferUseCase = createSdpOfferUseCase,
       _createSdpAnswerUseCase = createSdpAnswerUseCase,
       _disposeRenderersUseCase = disposeRenderersUseCase {
    _initialize();
  }

  RTCVideoRenderer get localRenderer => _webRTCRepository.localRenderer;

  RTCVideoRenderer get remoteRenderer => _webRTCRepository.remoteRenderer;

  Future<void> _initialize() async {
    _updateState(_state.copyWith(screenState: AppScreenState.loading));
    await _initializeRenderersUseCase.call();

    print('connecting server: ${Env.kolibriServerAddress}');
    final connectResult = await _connectSignalingUseCase.call(_serverUrl);
    switch (connectResult) {
      case Success<String>():
        _updateState(
          _state.copyWith(
            myId: connectResult.data,
            screenState: AppScreenState.lobby,
          ),
        );
        _listenToStreams();
      case Error<String>():
        _updateState(
          _state.copyWith(
            screenState: AppScreenState.error,
            errorMessage: "Connection failed: ${connectResult.message}",
          ),
        );
    }
  }

  void _listenToStreams() {
    _subscriptions.add(
      _getUserListStreamUseCase.call().listen((users) {
        _updateState(
          _state.copyWith(
            onlineUsers: users.where((u) => u.id != _state.myId).toList(),
          ),
        );
      }),
    );
    _subscriptions.add(_listenOfferUseCase.call().listen(_handleIncomingOffer));
    _subscriptions.add(
      _listenAnswerUseCase.call().listen(_handleIncomingAnswer),
    );
    _subscriptions.add(
      _listenIceCandidateUseCase.call().listen(_handleRemoteIceCandidate),
    );
    _subscriptions.add(_listenRefusalUseCase.call().listen(_handleCallRefused));
    _subscriptions.add(
      _listenHangUpUseCase.call().listen(_handlePeerDisconnected),
    );
    _subscriptions.add(
      _listenControlSignalUseCase.call().listen(_handleControlSignal),
    );
  }

  Future<void> _createAndConfigurePeerConnection() async {
    if (peerConnection != null) {
      await _disposePeerConnectionUseCase.call(peerConnection);
      peerConnection = null;
      remoteStream = null;
      _updateState(_state.copyWith(remoteVideoVisible: false));
    }
    final pcResult = await _createPeerConnectionUseCase.call();

    switch (pcResult) {
      case Success<RTCPeerConnection>():
        peerConnection = pcResult.data;

        _listenToPeerConnectionEvents(pcResult.data);
        if (localStream != null) {
          // If local media is already on
          _addTrackToPeerUseCase.call(localStream!, pcResult.data);
        }
      case Error<RTCPeerConnection>():
        _updateState(
          _state.copyWith(
            screenState: AppScreenState.error,
            errorMessage: "PC creation failed: ${pcResult.message}",
          ),
        );
    }
  }

  void _listenToPeerConnectionEvents(RTCPeerConnection pc) {
    _subscriptions.add(
      _listenOnIceCandidateGeneratedUseCase.call(pc).listen((candidate) async {
        if (_state.remotePeerId != null && _state.myId != null) {
          await _sendIceCandidateUseCase.call(
            IceCandidateInfoModel(
              to: _state.remotePeerId!,
              candidate: candidate.candidate!,
              sdpMid: candidate.sdpMid!,
              sdpMLineIndex: candidate.sdpMLineIndex!,
            ),
          );
        }
      }),
    );
    _subscriptions.add(
      _listenOnTrackUseCase.call(pc).listen((stream) {
        remoteStream = stream;
        _updateState(_state.copyWith(remoteVideoVisible: true));
      }),
    );
    _subscriptions.add(
      _listenConnectionStateUseCase.call(pc).listen((connectionState) {
        debugPrint("[ViewModel] Peer Connection State: $connectionState");
        if (connectionState ==
            RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
          peerConnection?.restartIce();
        } else if (connectionState ==
                RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
            connectionState ==
                RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
          if (_state.screenState == AppScreenState.inCall) {
            endCall(isRemoteHangup: true); // Treat as hangup if in call
          }
        }
      }),
    );
  }

  Future<void> _handleIncomingOffer(CallOfferModel offer) async {
    if (_state.screenState == AppScreenState.inCall || _state.myId == null) {
      if (_state.myId != null) {
        await _sendRefusalUseCase.call(
          toId: offer.fromId,
          fromId: _state.myId!,
        );
      }
      return;
    }

    await _createAndConfigurePeerConnection(); // Creates new PC or resets if one existed
    if (peerConnection == null) {
      _updateState(
        _state.copyWith(
          screenState: AppScreenState.error,
          errorMessage: "Failed to setup for incoming call.",
        ),
      );
      return;
    }

    await _setRemoteDescriptionUseCase.call(
      RTCSessionDescription(offer.sdp, offer.type),
      peerConnection!,
    );

    final mediaResult = await _getLocalUserMediaUseCase.call(
      audioOnly: offer.audioOnly,
    );

    switch (mediaResult) {
      case Success<MediaStream>():
        localStream = mediaResult.data;
        _updateState(
          _state.copyWith(
            localVideoEnabled: mediaResult.data.getVideoTracks().isNotEmpty,
          ),
        );
        if (peerConnection != null) {
          // Ensure PC still exists
          _addTrackToPeerUseCase.call(mediaResult.data, peerConnection!);
        }
      case Error<MediaStream>():
        _updateState(
          _state.copyWith(
            screenState: AppScreenState.error,
            errorMessage:
                "Media access failed for incoming call: ${mediaResult.message}",
          ),
        );
      // Optionally send refusal if media fails
    }

    _updateState(
      _state.copyWith(
        incomingOffer: offer,
        remotePeerId: offer.fromId,
        audioOnlyCall: offer.audioOnly,
        screenState: AppScreenState.incomingCall,
      ),
    );

    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 1500);
    }
  }

  Future<void> _handleIncomingAnswer(CallAnswerModel answer) async {
    if (peerConnection == null || _state.remotePeerId != answer.fromId) {
      return;
    }
    await _setRemoteDescriptionUseCase.call(
      RTCSessionDescription(answer.sdp, answer.type),
      peerConnection!,
    );
  }

  Future<void> _handleRemoteIceCandidate(IceCandidateInfoModel iceInfo) async {
    if (peerConnection == null || _state.myId != iceInfo.to) {
      return; // ICE is for me
    }
    final rtcIceCandidate = RTCIceCandidate(
      iceInfo.candidate,
      iceInfo.sdpMid,
      iceInfo.sdpMLineIndex,
    );
    await _addIceCandidateToPeerUseCase.call(rtcIceCandidate, peerConnection!);
  }

  void _handleControlSignal(domain_cs.ControlSignalModel signal) {
    if (signal.to == _state.myId) {
      debugPrint("[ViewModel] Received control signal: ${signal.type}");
      // TODO: Implement logic based on signal (e.g., update game character)
    }
  }

  void selectUserForCall(PeerUserModel user) {
    _updateState(_state.copyWith(selectedUserForCall: user));
  }

  Future<void> initiateCall({bool audioOnly = false}) async {
    if (_state.selectedUserForCall == null || _state.myId == null) {
      _updateState(
        _state.copyWith(errorMessage: "No user selected or not connected."),
      );
      return;
    }

    final toId = _state.selectedUserForCall!.id;
    _updateState(
      _state.copyWith(
        remotePeerId: toId,
        audioOnlyCall: audioOnly,
        screenState: AppScreenState.inCall,
      ),
    ); // Optimistically move to inCall

    await _createAndConfigurePeerConnection();
    if (peerConnection == null) {
      _updateState(
        _state.copyWith(
          screenState: AppScreenState.lobby,
          remotePeerId: null,
          errorMessage: "Failed to start call (PC).",
        ),
      );
      return;
    }

    final mediaResult = await _getLocalUserMediaUseCase.call(
      audioOnly: audioOnly,
    );
    switch (mediaResult) {
      case Success<MediaStream>():
        localStream = mediaResult.data;
        _updateState(
          _state.copyWith(
            localVideoEnabled: mediaResult.data.getVideoTracks().isNotEmpty,
          ),
        );
        _addTrackToPeerUseCase.call(mediaResult.data, peerConnection!);
      case Error<MediaStream>():
        _updateState(
          _state.copyWith(
            screenState: AppScreenState.lobby,
            remotePeerId: null,
            errorMessage: "Media access failed: ${mediaResult.message}",
          ),
        );
        _resetCallState();
        return;
    }
    // If media access failed critically (e.g. no stream for video call), we might have returned.

    final sdpOffer = await _createSdpOfferUseCase.call(
      peerConnection!,
      audioOnly: audioOnly,
    );
    await _setLocalDescriptionUseCase.call(sdpOffer, peerConnection!);

    final offerModel = CallOfferModel(
      fromId: _state.myId!,
      toId: toId,
      sdp: sdpOffer.sdp!,
      type: sdpOffer.type!,
      audioOnly: audioOnly,
    );

    final result = await _sendOfferUseCase.call(offerModel);
    switch (result) {
      case Success<void>():
      case Error<void>():
        _updateState(
          _state.copyWith(
            screenState: AppScreenState.lobby,
            remotePeerId: null,
            errorMessage: "Failed to send offer",
          ),
        );
        _resetCallState();
    }
  }

  Future<void> answerCall() async {
    if (_state.incomingOffer == null ||
        _state.myId == null ||
        peerConnection == null) {
      _updateState(
        _state.copyWith(
          screenState: AppScreenState.lobby,
          errorMessage: "Cannot answer call, missing information.",
        ),
      );
      _resetCallState();
      return;
    }

    // Ensure local media is active. It should be from _handleIncomingOffer, but double check.
    if (localStream == null) {
      final mediaResult = await _getLocalUserMediaUseCase.call(
        audioOnly: _state.audioOnlyCall,
      );

      switch (mediaResult) {
        case Success<MediaStream>():
          localStream = mediaResult.data;
          _updateState(
            _state.copyWith(
              localVideoEnabled: mediaResult.data.getVideoTracks().isNotEmpty,
            ),
          );
          _addTrackToPeerUseCase.call(mediaResult.data, peerConnection!);
        case Error<MediaStream>():
          _updateState(
            _state.copyWith(
              screenState: AppScreenState.lobby,
              errorMessage: "Media failed for answer: ${mediaResult.message}",
            ),
          );
          _resetCallState();
          _sendRefusalUseCase.call(
            toId: _state.remotePeerId!,
            fromId: _state.myId!,
          );
          return;
      }
    }

    final sdpAnswer = await _createSdpAnswerUseCase.call(
      peerConnection!,
      audioOnly: _state.audioOnlyCall,
    );
    await _setLocalDescriptionUseCase.call(sdpAnswer, peerConnection!);

    final answerModel = CallAnswerModel(
      fromId: _state.myId!,
      toId: _state.remotePeerId!,
      sdp: sdpAnswer.sdp!,
      type: sdpAnswer.type!,
      audioOnly: _state.audioOnlyCall,
    );

    final result = await _sendAnswerUseCase.call(answerModel);

    switch (result) {
      case Success<void>():
        _updateState(
          _state.copyWith(
            screenState: AppScreenState.inCall,
            incomingOffer: null,
          ),
        );
        Vibration.cancel();

      case Error<void>():
        _updateState(
          _state.copyWith(
            screenState: AppScreenState.lobby,
            errorMessage: "Failed to send answer: ${result.message}",
          ),
        );
        _resetCallState();
    }
  }

  Future<void> rejectCall() async {
    if (_state.remotePeerId != null && _state.myId != null) {
      await _sendRefusalUseCase.call(
        toId: _state.remotePeerId!,
        fromId: _state.myId!,
      );
    }
    await _resetCallState(); // Reset local state for the call being rejected
    _updateState(
      _state.copyWith(
        screenState: AppScreenState.lobby,
        incomingOffer: null,
        remotePeerId: null,
      ),
    );
    if (await Vibration.hasVibrator()) Vibration.cancel();
  }

  void _handleCallRefused(String fromId) async {
    if (_state.remotePeerId == fromId) {
      debugPrint("[ViewModel] Call refused by $fromId");
      await _resetCallState();
      _updateState(
        _state.copyWith(
          screenState: AppScreenState.lobby,
          remotePeerId: null,
          errorMessage: "Call refused by $fromId",
        ),
      );
      if (_callViewContext != null && Navigator.canPop(_callViewContext!)) {
        Navigator.pop(_callViewContext!);
        _callViewContext = null;
      }
    }
  }

  void _handlePeerDisconnected(String fromId) async {
    if (_state.remotePeerId == fromId &&
        _state.screenState == AppScreenState.inCall) {
      debugPrint("[ViewModel] Peer $fromId disconnected.");
      await endCall(isRemoteHangup: true);
    }
  }

  Future<void> endCall({bool isRemoteHangup = false}) async {
    if (!isRemoteHangup && _state.remotePeerId != null && _state.myId != null) {
      await _sendHangUpUseCase.call(
        toId: _state.remotePeerId!,
        fromId: _state.myId!,
      );
    }

    await _resetCallState(); // This handles media turn off and PC disposal
    _updateState(
      _state.copyWith(screenState: AppScreenState.lobby),
    ); // Always return to lobby

    if (_callViewContext != null && Navigator.canPop(_callViewContext!)) {
      Navigator.pop(_callViewContext!);
      _callViewContext = null;
    }
  }

  Future<void> _resetCallState() async {
    if (localStream != null) {
      await _turnOffLocalMediaUseCase.call(localStream);
    }
    if (peerConnection != null) {
      await _disposePeerConnectionUseCase.call(peerConnection);
    }
    peerConnection = null;
    localStream = null;
    remoteStream = null;

    _updateState(
      _state.copyWith(
        remotePeerId: null,
        localVideoEnabled: false,
        remoteVideoVisible: false,
        incomingOffer: null,
        selectedUserForCall: null,
        audioOnlyCall: false,
      ),
    );
  }

  Future<void> toggleLocalMedia() async {
    if (localStream != null) {
      await _turnOffLocalMediaUseCase.call(localStream);
      localStream = null;
      _updateState(_state.copyWith(localVideoEnabled: false));
    } else {
      final mediaResult = await _getLocalUserMediaUseCase.call(
        audioOnly: _state.audioOnlyCall,
      );
      switch (mediaResult) {
        case Success<MediaStream>():
          localStream = mediaResult.data;
          _updateState(
            _state.copyWith(
              localVideoEnabled: mediaResult.data.getVideoTracks().isNotEmpty,
            ),
          );
          if (peerConnection != null &&
              (peerConnection!.connectionState ==
                      RTCPeerConnectionState.RTCPeerConnectionStateConnected ||
                  peerConnection!.connectionState ==
                      RTCPeerConnectionState.RTCPeerConnectionStateNew)) {
            // Check if PC exists and is in a valid state to add tracks
            _addTrackToPeerUseCase.call(mediaResult.data, peerConnection!);
          }
        case Error<MediaStream>():
          _updateState(
            _state.copyWith(
              errorMessage: "Toggle media failed: ${mediaResult.message}",
            ),
          );
      }
    }
  }

  void sendControlSignal(domain_cs.ControlSignalModel signal) {
    if (_state.remotePeerId != null && _state.myId != null) {
      final signalToSend = signal.copyWith(to: _state.remotePeerId!);
      _sendControlSignalUseCase.call(signalToSend);
    } else {
      debugPrint(
        "[ViewModel] Cannot send control signal: No active call or IDs missing.",
      );
    }
  }

  void _updateState(WebrtcPageState newState) {
    _state = newState;
    notifyListeners();
  }

  void setCallViewContext(BuildContext context) => _callViewContext = context;

  void clearCallViewContext() => _callViewContext = null;

  @override
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    _disconnectSignalingUseCase.call();
    if (localStream != null) {
      _turnOffLocalMediaUseCase.call(localStream);
    }
    if (peerConnection != null) {
      _disposePeerConnectionUseCase.call(peerConnection);
    }
    _disposeRenderersUseCase.call();
    super.dispose();
  }
}

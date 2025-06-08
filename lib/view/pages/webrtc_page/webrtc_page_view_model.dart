import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';
import 'package:kolibri_project/domain/model/call_answer_model.dart';
import 'package:kolibri_project/domain/use_case/webrtc/media_peer_connection/turn_on_local_media_stream_use_case.dart';
import 'package:kolibri_project/domain/use_case/webrtc/signaling/listen_for_ice_candidates_use_case.dart';
import 'package:kolibri_project/domain/use_case/webrtc/signaling/send_ice_candidate_use_case.dart';
import 'package:kolibri_project/env/env.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_state.dart';
import 'package:vibration/vibration.dart';

import '../../../domain/model/call_offer_model.dart'; // Ensure this is correctly imported
import '../../../domain/model/control_signal_model.dart' as domain_cs;
import '../../../domain/model/ice_candidate_info_model.dart';
import '../../../domain/model/peer_user_model.dart';
import '../../../domain/repository/webrtc_repository.dart';
// Import ALL your use cases here...
import '../../../domain/use_case/webrtc/media_peer_connection/add_ice_candidate_to_peer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/add_track_to_peer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/create_peer_connection_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/create_sdp_answer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/create_sdp_offer_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/set_local_description_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/set_remote_description_use_case.dart';
import '../../../domain/use_case/webrtc/media_peer_connection/turn_off_media_stream_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/accept_incoming_call_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/call_peer_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/close_peer_connection_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/connect_signaling_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/decline_incoming_call_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/disconnect_signaling_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/hang_up_call_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_for_call_answer_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_for_call_offers_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_for_control_signal_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_for_hang_up_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_for_refused_call_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/listen_for_user_list_use_case.dart';
import '../../../domain/use_case/webrtc/signaling/send_control_signal_use_case.dart';

class WebRTCViewModel with ChangeNotifier {
  final WebRTCRepository _webRTCRepository;

  //media_peer_connection
  final AddIceCandidateToPeerUseCase _addIceCandidateToPeerUseCase;
  final AddTrackToPeerUseCase _addTrackToPeerUseCase;
  final CreatePeerConnectionUseCase _createPeerConnectionUseCase;
  final CreateSdpAnswerUseCase _createSdpAnswerUseCase;
  final CreateSdpOfferUseCase _createSdpOfferUseCase;
  final SetLocalDescriptionUseCase _setLocalDescriptionUseCase;
  final SetRemoteDescriptionUseCase _setRemoteDescriptionUseCase;
  final TurnOffMediaStreamUseCase _turnOffMediaStreamUseCase;
  final TurnOnLocalMediaStreamUseCase _turnOnLocalMediaStreamUseCase;

  //signaling
  final AcceptIncomingCallUseCase _acceptIncomingCallUseCase;
  final CallPeerUseCase _callPeerUseCase;
  final ConnectSignalingUseCase _connectSignalingUseCase;
  final DeclineIncomingCallUseCase _declineIncomingCallUseCase;
  final DisconnectSignalingUseCase _disconnectSignalingUseCase;
  final HangUpCallUseCase _hangUpCallUseCase;
  final ListenForCallAnswerUseCase _listenForCallAnswerUseCase;
  final ListenForCallOffersUseCase _listenForCallOffersUseCase;
  final ListenForControlSignalUseCase _listenForControlSignalUseCase;
  final ListenForIceCandidatesUseCase _listenForIceCandidatesUseCase;
  final ListenForRefusedCallUseCase _listenForRefusedCallUseCase;
  final ListenForUserListUseCase _listenForUserListUseCase;
  final SendControlSignalUseCase _sendControlSignalUseCase;
  final SendIceCandidateUseCase _sendIceCandidateUseCase;
  final ListenForHangUpUseCase _listenForHangUpUseCase;
  final ClosePeerConnectionUseCase _closePeerConnectionUseCase;

  WebRTCViewModel({
    required WebRTCRepository webRTCRepository,
    required AddIceCandidateToPeerUseCase addIceCandidateToPeerUseCase,
    required AddTrackToPeerUseCase addTrackToPeerUseCase,
    required CreatePeerConnectionUseCase createPeerConnectionUseCase,
    required CreateSdpAnswerUseCase createSdpAnswerUseCase,
    required CreateSdpOfferUseCase createSdpOfferUseCase,
    required SetLocalDescriptionUseCase setLocalDescriptionUseCase,
    required SetRemoteDescriptionUseCase setRemoteDescriptionUseCase,
    required TurnOffMediaStreamUseCase turnOffMediaStreamUseCase,
    required TurnOnLocalMediaStreamUseCase turnOnLocalMediaStreamUseCase,
    required AcceptIncomingCallUseCase acceptIncomingCallUseCase,
    required CallPeerUseCase callPeerUseCase,
    required ConnectSignalingUseCase connectSignalingUseCase,
    required DeclineIncomingCallUseCase declineIncomingCallUseCase,
    required DisconnectSignalingUseCase disconnectSignalingUseCase,
    required HangUpCallUseCase hangUpCallUseCase,
    required ListenForCallAnswerUseCase listenForCallAnswerUseCase,
    required ListenForCallOffersUseCase listenForCallOffersUseCase,
    required ListenForControlSignalUseCase listenForControlSignalUseCase,
    required ListenForIceCandidatesUseCase listenForIceCandidatesUseCase,
    required ListenForRefusedCallUseCase listenForRefusedCallUseCase,
    required ListenForUserListUseCase listenForUserListUseCase,
    required SendControlSignalUseCase sendControlSignalUseCase,
    required SendIceCandidateUseCase sendIceCandidateUseCase,
    required ListenForHangUpUseCase listenForHangUpUseCase,
    required ClosePeerConnectionUseCase closePeerConnectionUseCase,
  }) : _webRTCRepository = webRTCRepository,
       _addIceCandidateToPeerUseCase = addIceCandidateToPeerUseCase,
       _addTrackToPeerUseCase = addTrackToPeerUseCase,
       _createPeerConnectionUseCase = createPeerConnectionUseCase,
       _createSdpAnswerUseCase = createSdpAnswerUseCase,
       _createSdpOfferUseCase = createSdpOfferUseCase,
       _setLocalDescriptionUseCase = setLocalDescriptionUseCase,
       _setRemoteDescriptionUseCase = setRemoteDescriptionUseCase,
       _turnOffMediaStreamUseCase = turnOffMediaStreamUseCase,
       _turnOnLocalMediaStreamUseCase = turnOnLocalMediaStreamUseCase,
       _acceptIncomingCallUseCase = acceptIncomingCallUseCase,
       _callPeerUseCase = callPeerUseCase,
       _connectSignalingUseCase = connectSignalingUseCase,
       _declineIncomingCallUseCase = declineIncomingCallUseCase,
       _disconnectSignalingUseCase = disconnectSignalingUseCase,
       _hangUpCallUseCase = hangUpCallUseCase,
       _listenForCallAnswerUseCase = listenForCallAnswerUseCase,
       _listenForCallOffersUseCase = listenForCallOffersUseCase,
       _listenForControlSignalUseCase = listenForControlSignalUseCase,
       _listenForIceCandidatesUseCase = listenForIceCandidatesUseCase,
       _listenForRefusedCallUseCase = listenForRefusedCallUseCase,
       _listenForUserListUseCase = listenForUserListUseCase,
       _sendControlSignalUseCase = sendControlSignalUseCase,
       _sendIceCandidateUseCase = sendIceCandidateUseCase,
       _listenForHangUpUseCase = listenForHangUpUseCase,
       _closePeerConnectionUseCase = closePeerConnectionUseCase {
    init();
  }

  WebrtcPageState _state = const WebrtcPageState();

  WebrtcPageState get state => _state;

  RTCPeerConnection? _peerConnection;
  MediaStream? localStream; // Managed here directly
  MediaStream? remoteStream; // Managed here directly
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  final List<StreamSubscription> _subscriptions = [];

  BuildContext? _callViewContext; // Context for programmatic navigation

  void init() async {
    _updateState(_state.copyWith(screenState: AppScreenState.loading));
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    _connectSignalingUseCase.call(Env.kolibriServerAddress).listen((result) {
      switch (result) {
        case Success<String>():
          _updateState(
            _state.copyWith(
              myId: result.data,
              screenState: AppScreenState.lobby,
            ),
          );
          _setupSignalingListeners();
          break;
        case Error<String>():
          _updateState(
            _state.copyWith(
              errorMessage: "Failed to connect: ${result.message}",
              screenState: AppScreenState.error,
            ),
          );
          break;
      }
    });
  }

  void _setupSignalingListeners() {
    // User list updates
    _listenForUserListUseCase
        .call()
        .listen((users) {
          final peerUsers = users
              .where((user) => user.id != _state.myId)
              .map((userData) => PeerUserModel(id: userData.id))
              .toList();
          _updateState(_state.copyWith(onlineUsers: peerUsers));
        })
        .addTo(_subscriptions);

    // Incoming call offers (수신자용)
    _listenForCallOffersUseCase
        .call()
        .listen((offer) async {
          debugPrint('[ViewModel] Incoming offer from ${offer.fromId}');
          // Vibrate on incoming call if possible
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate(duration: 1000);
          }
          _updateState(
            _state.copyWith(
              incomingOffer: offer,
              remotePeerId: offer.fromId,
              screenState: AppScreenState.incomingCall,
              audioOnlyCall: offer.audioOnly,
            ),
          );
        })
        .addTo(_subscriptions);

    // Answer received (for caller) 발신자용
    _listenForCallAnswerUseCase
        .call()
        .listen((answer) async {
          if (_peerConnection != null &&
              _state.remotePeerId == answer.fromId &&
              _state.screenState == AppScreenState.loading) {
            debugPrint('[ViewModel] Received answer from ${answer.fromId}');
            try {
              await _setRemoteDescriptionUseCase.call(
                _peerConnection!,
                RTCSessionDescription(answer.sdp, answer.type),
              );
              debugPrint(
                '[ViewModel] Successfully set remote description from answer',
              );
              _updateState(
                _state.copyWith(
                  screenState: AppScreenState.inCall,
                  audioOnlyCall: answer.audioOnly, // Update based on answer
                  localVideoEnabled: !answer
                      .audioOnly, // If not audio only, local video should be enabled
                  // remoteVideoVisible will be updated by onTrack listener
                ),
              );
            } catch (e) {
              debugPrint('[ViewModel] Error setting remote description: $e');
              _updateState(
                _state.copyWith(
                  errorMessage: 'Failed to process answer: $e',
                  screenState: AppScreenState.lobby,
                ),
              );
              _cleanupCall();
            }
          }
        })
        .addTo(_subscriptions);

    // ICE Candidate received
    _listenForIceCandidatesUseCase
        .call()
        .listen((candidateInfo) async {
          if (_peerConnection != null &&
              _state.remotePeerId == candidateInfo.from) {
            debugPrint(
              '[ViewModel] Received ICE Candidate from ${candidateInfo.from}',
            );
            await _addIceCandidateToPeerUseCase.call(
              RTCIceCandidate(
                candidateInfo.candidate,
                candidateInfo.sdpMid,
                candidateInfo.sdpMLineIndex,
              ),
              _peerConnection!,
            );
          }
        })
        .addTo(_subscriptions);

    // Remote hang up
    _listenForHangUpUseCase
        .call()
        .listen((fromId) async {
          if (_state.remotePeerId == fromId) {
            debugPrint('[ViewModel] Remote peer $fromId hung up.');
            await hangUp();
          }
        })
        .addTo(_subscriptions);

    // Call refusal
    _listenForRefusedCallUseCase
        .call()
        .listen((fromId) {
          if (_state.remotePeerId == fromId) {
            debugPrint('[ViewModel] Remote peer $fromId refused call.');
            _updateState(
              _state.copyWith(
                screenState: AppScreenState.lobby,
                remotePeerId: null,
                incomingOffer: null,
                errorMessage: 'Call to $fromId was refused.',
              ),
            );
            _cleanupCall();
          }
        })
        .addTo(_subscriptions);

    // Control Signals
    _listenForControlSignalUseCase
        .call()
        .listen((signal) {
          debugPrint('[ViewModel] Received control signal: ${signal.type}');
          switch (signal.type) {
            case domain_cs.ControlSignalType.joystick:
              _handleJoystickSignal(signal);
              break;
            case domain_cs.ControlSignalType.drag:
              _handleDragSignal(signal);
              break;
            case domain_cs.ControlSignalType.zoom:
              _handleZoomSignal(signal);
              break;
          }
        })
        .addTo(_subscriptions);
  }

  // region Call Actions

  Future<void> callUser(PeerUserModel user, {bool audioOnly = false}) async {
    _updateState(
      _state.copyWith(
        selectedUserForCall: user,
        remotePeerId: user.id,
        audioOnlyCall: audioOnly,
        screenState: AppScreenState.loading,
        // Indicate calling state
        localVideoEnabled: !audioOnly,
        // Set initial local video state
        remoteVideoVisible: false, // Reset remote video visibility
      ),
    );

    await _initializeCall(audioOnly: audioOnly);

    if (_peerConnection == null || localStream == null) {
      _updateState(
        _state.copyWith(
          errorMessage: 'Failed to initialize peer connection or local stream.',
          screenState: AppScreenState.lobby,
        ),
      );
      return;
    }

    final offerResult = await _createSdpOfferUseCase.call(_peerConnection!);

    switch (offerResult) {
      case Success<RTCSessionDescription>():
        final offer = offerResult.data;
        await _setLocalDescriptionUseCase.call(_peerConnection!, offer);
        _callPeerUseCase.call(
          CallOfferModel(
            fromId: _state.myId!,
            toId: user.id,
            sdp: offer.sdp!,
            type: offer.type!,
            audioOnly: audioOnly,
          ),
        );
        // _updateState(_state.copyWith(screenState: AppScreenState.inCall));
        break;
      case Error<RTCSessionDescription>():
        _updateState(
          _state.copyWith(
            errorMessage: 'Failed to create offer: ${offerResult.message}',
            screenState: AppScreenState.lobby,
          ),
        );
        _cleanupCall();
        break;
    }
  }

  Future<void> acceptIncomingCall() async {
    if (_state.incomingOffer == null ||
        _state.remotePeerId == null ||
        _state.myId == null) {
      debugPrint('[ViewModel] No incoming offer to accept or missing IDs.');
      return;
    }

    _updateState(
      _state.copyWith(
        screenState: AppScreenState.loading,
        localVideoEnabled: !_state.incomingOffer!.audioOnly,
        // Set local video state based on incoming offer
        remoteVideoVisible: false, // Reset remote video visibility
      ),
    );

    await _initializeCall(audioOnly: _state.audioOnlyCall);

    if (_peerConnection == null || localStream == null) {
      _updateState(
        _state.copyWith(
          errorMessage: 'Failed to initialize peer connection or local stream.',
          screenState: AppScreenState.lobby,
        ),
      );
      return;
    }

    try {
      // 1. 받은 offer를 remote description으로 설정
      debugPrint('[ViewModel] Setting remote description with offer');
      await _setRemoteDescriptionUseCase.call(
        _peerConnection!,
        RTCSessionDescription(
          _state.incomingOffer!.sdp,
          _state.incomingOffer!.type,
        ),
      );

      // 2. Answer 생성
      debugPrint('[ViewModel] Creating answer');
      final answerResult = await _createSdpAnswerUseCase.call(_peerConnection!);

      switch (answerResult) {
        case Success<RTCSessionDescription>():
          final answer = answerResult.data;

          // 3. Answer를 local description으로 설정
          debugPrint('[ViewModel] Setting local description with answer');
          await _setLocalDescriptionUseCase.call(_peerConnection!, answer);

          // 4. Answer를 발신자에게 전송
          final callAnswer = CallAnswerModel(
            fromId: _state.myId!,
            toId: _state.remotePeerId!,
            sdp: answer.sdp!,
            type: answer.type!,
            audioOnly: _state.audioOnlyCall,
          );

          debugPrint('[ViewModel] Sending answer to ${_state.remotePeerId}');
          _acceptIncomingCallUseCase.call(callAnswer);

          // 5. 통화 상태로 전환
          _updateState(
            _state.copyWith(
              screenState: AppScreenState.inCall,
              incomingOffer: null, // offer 처리 완료
            ),
          );

          break;

        case Error<RTCSessionDescription>():
          debugPrint(
            '[ViewModel] Failed to create answer: ${answerResult.message}',
          );
          _updateState(
            _state.copyWith(
              errorMessage: 'Failed to create answer: ${answerResult.message}',
              screenState: AppScreenState.lobby,
            ),
          );
          _cleanupCall();
          break;
      }
    } catch (e) {
      debugPrint('[ViewModel] Error during acceptIncomingCall: $e');
      _updateState(
        _state.copyWith(
          errorMessage: 'Error accepting call: $e',
          screenState: AppScreenState.lobby,
        ),
      );
      _cleanupCall();
    }
  }

  Future<void> refuseIncomingCall() async {
    if (_state.incomingOffer != null && _state.remotePeerId != null) {
      _declineIncomingCallUseCase.call(_state.remotePeerId!);
    }
    _resetState();
    _cleanupCall();
  }

  Future<void> hangUp() async {
    if (_state.remotePeerId != null && _state.myId != null) {
      _hangUpCallUseCase.call(_state.myId!, _state.remotePeerId!);
    }
    _resetState();
    _cleanupCall();
  }

  // endregion

  // region Media Control

  Future<void> _initializeCall({required bool audioOnly}) async {
    // 1. Get local media stream
    final mediaResult = await _turnOnLocalMediaStreamUseCase.call(
      audioOnly: audioOnly,
      localRenderer: localRenderer,
    );
    switch (mediaResult) {
      case Success<MediaStream>():
        localStream = mediaResult.data; // Assign to localStream
        localRenderer.srcObject = localStream;
        _updateState(_state.copyWith(localVideoEnabled: !audioOnly));
        // 2. Create Peer Connection
        final peerConnectionResult = await _createPeerConnectionUseCase.call();
        switch (peerConnectionResult) {
          case Success<RTCPeerConnection>():
            _peerConnection = peerConnectionResult.data;
            _setupPeerConnectionListeners(_peerConnection!);

            // Add local stream tracks to peer connection
            if (localStream != null) {
              _addTrackToPeerUseCase.call(localStream!, _peerConnection!);
            }

            break;
          case Error<RTCPeerConnection>():
            _updateState(
              _state.copyWith(
                errorMessage:
                    "Failed to create peer connection: ${peerConnectionResult.message}",
                screenState: AppScreenState.error,
              ),
            );
            _cleanupCall(); // Cleanup if PC creation fails
            return;
        }
      case Error<MediaStream>():
        _updateState(
          _state.copyWith(
            errorMessage: "Toggle media failed: ${mediaResult.message}",
          ),
        );
    }
  }

  void _setupPeerConnectionListeners(RTCPeerConnection peerConnection) {
    // On ICE Candidate
    _webRTCRepository
        .getOnIceCandidateStream(peerConnection)
        .listen((candidate) {
          if (_state.remotePeerId != null && _state.myId != null) {
            _sendIceCandidateUseCase.call(
              IceCandidateInfoModel(
                from: _state.myId!,
                to: _state.remotePeerId!,
                candidate: candidate.candidate!,
                sdpMid: candidate.sdpMid!,
                sdpMLineIndex: candidate.sdpMLineIndex!,
              ),
            );
          }
        })
        .addTo(_subscriptions);

    // On Track (remote stream)
    _webRTCRepository
        .getOnTrackStream(peerConnection, remoteRenderer)
        .listen((stream) {
      debugPrint(
        '[ViewModel] Remote track received, Stream ID: ${stream.id}',
      );
      remoteStream = stream; // Assign to remoteStream
      remoteRenderer.srcObject = stream;
      _updateState(_state.copyWith(remoteVideoVisible: true));
    })
        .addTo(_subscriptions);

    // // On Track (remote stream)
    // peerConnection.onTrack = (RTCTrackEvent event) {
    //   debugPrint(
    //     '[ViewModel] onTrack event received. Track kind: ${event.track.kind}, Stream ID: ${event.streams.first.id}',
    //   );
    //   if (event.track.kind == 'video' && event.streams.isNotEmpty) {
    //     remoteStream = event.streams[0];
    //     remoteRenderer.srcObject = remoteStream;
    //     _updateState(_state.copyWith(remoteVideoVisible: true));
    //     debugPrint('[ViewModel] Remote video track added, remoteRenderer srcObject set.');
    //   } else if (event.track.kind == 'audio' && event.streams.isNotEmpty) {
    //     // Handle audio tracks if needed, though they don't need a renderer
    //     debugPrint('[ViewModel] Remote audio track added.');
    //   }
    // };

    // On Connection State Change
    _webRTCRepository
        .getOnConnectionStateStream(peerConnection)
        .listen((state) async {
          debugPrint('[ViewModel] Peer connection state changed: $state');
          // Handle connection state changes (e.g., connected, disconnected, failed)
          if (state ==
                  RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
              state == RTCPeerConnectionState.RTCPeerConnectionStateClosed ||
              state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
            if (_state.screenState == AppScreenState.inCall) {
              await hangUp(); // Automatically hang up on disconnection/failure
            }
          } else if (state ==
              RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
            debugPrint('[ViewModel] Peer connection established!');
          }
        })
        .addTo(_subscriptions);
  }

  Future<void> toggleMicrophone() async {
    if (localStream != null) {
      final audioTrack = localStream!.getAudioTracks().firstOrNull;
      if (audioTrack != null) {
        audioTrack.enabled = !audioTrack.enabled;
        // The audioOnlyCall state might represent if video is OFF.
        // For mic mute, we usually have a separate state.
        // For simplicity, we just toggle the track's enabled state.
        debugPrint(
          "[ViewModel] Local audio track enabled: ${audioTrack.enabled}",
        );
        notifyListeners(); // Notify UI for mic icon change
      }
    }
  }

  Future<void> toggleCamera() async {
    if (localStream != null) {
      final videoTrack = localStream!.getVideoTracks().firstOrNull;
      if (videoTrack != null) {
        videoTrack.enabled = !videoTrack.enabled;
        _updateState(_state.copyWith(localVideoEnabled: videoTrack.enabled));
        debugPrint(
          "[ViewModel] Local video track enabled: ${videoTrack.enabled}",
        );
      }
    }
  }

  // Control Signal Handlers
  void _handleJoystickSignal(domain_cs.ControlSignalModel signal) {
    debugPrint(
      '[ViewModel] Joystick signal: angle=${signal.angle}, intensity=${signal.intensity}',
    );
    _updateState(_state.copyWith(lastReceivedControlSignal: signal));
  }

  void _handleDragSignal(domain_cs.ControlSignalModel signal) {
    debugPrint('[ViewModel] Drag signal: dx=${signal.dx}, dy=${signal.dy}');
    _updateState(_state.copyWith(lastReceivedControlSignal: signal));
  }

  void _handleZoomSignal(domain_cs.ControlSignalModel signal) {
    debugPrint('[ViewModel] Zoom signal: scale=${signal.scale}');
    _updateState(_state.copyWith(lastReceivedControlSignal: signal));
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

  void _cleanupCall() {
    debugPrint("[ViewModel] Cleaning up call resources.");
    // Cancel all current streams and dispose resources
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    if (_peerConnection != null) {
      _closePeerConnectionUseCase.call(
        _peerConnection!,
        localStream,
        localRenderer,
      );
      _peerConnection = null;
    }

    if (localStream != null) {
      _turnOffMediaStreamUseCase.call(localStream!, localRenderer);
      localStream = null;
    }
    if (remoteStream != null) {
      _turnOffMediaStreamUseCase.call(remoteStream!, remoteRenderer);
      remoteStream = null;
    }

    // Clear renderers' srcObject
    localRenderer.srcObject = null;
    remoteRenderer.srcObject = null;

    // Pop the call view if it's still active
    if (_callViewContext != null && Navigator.canPop(_callViewContext!)) {
      Navigator.pop(_callViewContext!);
    }
    _callViewContext = null;
  }

  void _resetState() {
    localStream = null;
    remoteStream = null;
    _updateState(
      _state.copyWith(
        screenState: AppScreenState.lobby,
        incomingOffer: null,
        remotePeerId: null,
        audioOnlyCall: false,
        localVideoEnabled: false,
        // Reset local video state
        remoteVideoVisible: false,
        // Reset remote video state
        errorMessage: null,
      ),
    );
  }

  @override
  void dispose() {
    debugPrint("[ViewModel] Disposing ViewModel.");
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    _disconnectSignalingUseCase.call(); // Disconnect signaling
    _cleanupCall(); // Ensure all call resources are cleaned up

    // Dispose renderers
    localRenderer.dispose();
    remoteRenderer.dispose();

    super.dispose();
  }
}

// Extension to add StreamSubscription to a list
extension StreamSubscriptionExtension<T> on StreamSubscription<T> {
  void addTo(List<StreamSubscription> subscriptions) {
    subscriptions.add(this);
  }
}

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
          _webRTCRepository.requestUserList();
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

    // Remote hang up 리스너 개선
    _listenForHangUpUseCase
        .call()
        .listen((fromId) async {
          debugPrint('[ViewModel] Remote peer $fromId hung up.');
          if (_state.remotePeerId == fromId) {
            await _handleRemoteHangUp();
          }
        })
        .addTo(_subscriptions);
  }

  // 2. 원격 통화 종료 처리 함수
  Future<void> _handleRemoteHangUp() async {
    debugPrint('[ViewModel] Handling remote hang up');

    // 상태 업데이트
    _updateState(
      _state.copyWith(
        screenState: AppScreenState.lobby,
        remotePeerId: null,
        incomingOffer: null,
        audioOnlyCall: false,
        localVideoEnabled: false,
        remoteVideoVisible: false,
        errorMessage: 'Call ended by remote peer',
      ),
    );

    // 리소스 정리
    await _cleanupCall();

    // 사용자 목록 새로고침
    _webRTCRepository.requestUserList();
  }

  // 3. 자동 재연결 함수
  void _attemptReconnection() {
    Timer(const Duration(seconds: 3), () {
      if (_state.screenState == AppScreenState.error) {
        debugPrint('[ViewModel] Attempting to reconnect...');
        init();
      }
    });
  }

  // region Call Actions

  Future<void> callUser(PeerUserModel user, {bool audioOnly = false}) async {
    _updateState(
      _state.copyWith(
        selectedUserForCall: user,
        remotePeerId: user.id,
        audioOnlyCall: audioOnly,
        screenState: AppScreenState.loading,
        localVideoEnabled: !audioOnly,
        remoteVideoVisible: false,
        // Reset remote video visibility
        errorMessage: null,
      ),
    );
    try {
      // 1. 통화 초기화 (리스너 설정 포함)
      debugPrint('[ViewModel] Initializing call...');
      await _initializeCall(audioOnly: audioOnly);

      if (_peerConnection == null || localStream == null) {
        throw Exception('Failed to initialize peer connection or local stream');
      }

      // 2. 초기화 완료 후 추가 대기 (네트워크 안정화)
      await Future.delayed(const Duration(milliseconds: 300));

      debugPrint('[ViewModel] Creating SDP offer...');

      // 3. SDP Offer 생성
      final offerResult = await _createSdpOfferUseCase.call(_peerConnection!);

      switch (offerResult) {
        case Success<RTCSessionDescription>():
          final offer = offerResult.data;

          debugPrint('[ViewModel] Setting local description...');
          await _setLocalDescriptionUseCase.call(_peerConnection!, offer);

          // 4. Local description 설정 후 약간의 대기
          await Future.delayed(const Duration(milliseconds: 100));

          debugPrint('[ViewModel] Sending call offer to ${user.id}...');
          _callPeerUseCase.call(
            CallOfferModel(
              fromId: _state.myId!,
              toId: user.id,
              sdp: offer.sdp!,
              type: offer.type!,
              audioOnly: audioOnly,
            ),
          );

          // 5. 상태를 loading으로 유지 (답변 대기)
          debugPrint('[ViewModel] Call offer sent, waiting for answer...');
          _updateState(
            _state.copyWith(
              screenState: AppScreenState.loading, // inCall이 아닌 loading으로
              errorMessage: null,
            ),
          );

          break;

        case Error<RTCSessionDescription>():
          throw Exception('Failed to create offer: ${offerResult.message}');
      }
    } catch (e) {
      debugPrint('[ViewModel] Error in callUser: $e');
      _updateState(
        _state.copyWith(
          errorMessage: 'Failed to start call: $e',
          screenState: AppScreenState.lobby,
        ),
      );
      _cleanupCall();
      rethrow;
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

    // 마이크 기본 활성화
    final audioTracks = localStream!.getAudioTracks();
    if (audioTracks.isNotEmpty) {
      audioTracks.first.enabled = true;
      debugPrint('[ViewModel] Audio track enabled for incoming call');
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
          await _cleanupCall();
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
      await _cleanupCall();
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
    await _cleanupCall();
    // 사용자 목록 새로고침 요청
    _webRTCRepository.requestUserList();
  }

  // endregion

  // region Media Control
  Future<void> _initializeCall({required bool audioOnly}) async {
    try {
      debugPrint(
        '[ViewModel] Getting local media stream, audioOnly: $audioOnly',
      );

      // 1. Get local media stream
      final mediaResult = await _turnOnLocalMediaStreamUseCase.call(
        audioOnly: audioOnly,
        localRenderer: localRenderer,
      );

      switch (mediaResult) {
        case Success<MediaStream>():
          localStream = mediaResult.data;
          // 오디오 트랙 활성화 확인
          final audioTracks = localStream!.getAudioTracks();
          if (audioTracks.isNotEmpty) {
            audioTracks.first.enabled = true; // 오디오 트랙 활성화
            debugPrint(
              '[ViewModel] Local audio track enabled: ${audioTracks.first.enabled}',
            );
          }

          // 비디오 트랙 설정
          final videoTracks = localStream!.getVideoTracks();
          if (videoTracks.isNotEmpty && !audioOnly) {
            videoTracks.first.enabled = true;
            debugPrint(
              '[ViewModel] Local video track enabled: ${videoTracks.first.enabled}',
            );
          }
          localRenderer.srcObject = localStream;
          _updateState(_state.copyWith(localVideoEnabled: !audioOnly));
          debugPrint('[ViewModel] Local media stream obtained successfully');

          // 2. Create Peer Connection
          debugPrint('[ViewModel] Creating peer connection...');
          final peerConnectionResult = await _createPeerConnectionUseCase
              .call();

          switch (peerConnectionResult) {
            case Success<RTCPeerConnection>():
              _peerConnection = peerConnectionResult.data;
              debugPrint('[ViewModel] Peer connection created successfully');

              // 3. 리스너 설정을 가장 먼저 (트랙 추가 전에)
              _setupPeerConnectionListeners(_peerConnection!);
              // 4. Add local stream tracks to peer connection
              if (localStream != null) {
                debugPrint(
                  '[ViewModel] Adding local tracks to peer connection...',
                );
                _addTrackToPeerUseCase.call(localStream!, _peerConnection!);

                // 트랙 추가 후 지연
                await Future.delayed(const Duration(milliseconds: 200));
                debugPrint('[ViewModel] Local tracks added to peer connection');
              }
              break;

            case Error<RTCPeerConnection>():
              throw Exception(
                'Failed to create peer connection: ${peerConnectionResult.message}',
              );
          }
          break;

        case Error<MediaStream>():
          throw Exception('Failed to get media stream: ${mediaResult.message}');
      }
    } catch (e) {
      debugPrint('[ViewModel] Error in _initializeCall: $e');
      rethrow;
    }
  }

  void _setupPeerConnectionListeners(RTCPeerConnection peerConnection) {
    debugPrint('[ViewModel] Setting up peer connection listeners...');

    try {
      // 1. ICE Candidate 리스너
      peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
        debugPrint(
          '[ViewModel] ICE Candidate generated: ${candidate.candidate}',
        );
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
      };

      // 2. Track 리스너 - 더 강화된 처리
      peerConnection.onTrack = (RTCTrackEvent event) {
        debugPrint('[ViewModel] ========== onTrack event triggered ==========');
        debugPrint('[ViewModel] Track kind: ${event.track.kind}');
        debugPrint('[ViewModel] Track enabled: ${event.track.enabled}');
        debugPrint('[ViewModel] Streams count: ${event.streams.length}');

        if (event.streams.isNotEmpty) {
          final stream = event.streams.first;
          debugPrint('[ViewModel] Remote stream received - ID: ${stream.id}');

          // 기존 remote stream 정리
          if (remoteStream != null) {
            remoteStream!.dispose();
          }
          // Remote stream 설정
          remoteStream = stream;

          // 비디오 트랙 확인
          final videoTracks = stream.getVideoTracks();
          final audioTracks = stream.getAudioTracks();

          debugPrint('[ViewModel] Video tracks: ${videoTracks.length}');
          debugPrint('[ViewModel] Audio tracks: ${audioTracks.length}');

          // 비디오 트랙이 있는지 확인
          bool hasVideoTrack = false;
          if (videoTracks.isNotEmpty) {
            final videoTrack = videoTracks.first;
            hasVideoTrack = videoTrack.enabled;
            debugPrint(
              '[ViewModel] Video track enabled: ${videoTrack.enabled}',
            );
          }

          // 오디오 트랙 확인 및 활성화
          if (audioTracks.isNotEmpty) {
            final audioTrack = audioTracks.first;
            audioTrack.enabled = true; // 오디오 트랙 활성화
            debugPrint(
              '[ViewModel] Audio track enabled: ${audioTrack.enabled}',
            );
          }

          // UI 스레드에서 renderer 업데이트
          WidgetsBinding.instance.addPostFrameCallback((_) {
            try {
              remoteRenderer.srcObject = stream;
              debugPrint('[ViewModel] Remote renderer srcObject set');

              // 상태 업데이트
              _updateState(_state.copyWith(remoteVideoVisible: hasVideoTrack));

              // 강제로 renderer 새로고침
              remoteRenderer.notifyListeners();
            } catch (e) {
              debugPrint('[ViewModel] Error setting remote renderer: $e');
            }
          });
        }
      };

      // 3. Connection State 리스너
      peerConnection.onConnectionState = (RTCPeerConnectionState state) async {
        debugPrint('[ViewModel] Connection state changed: $state');

        switch (state) {
          case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
            debugPrint('[ViewModel] Peer connection established successfully!');
            // 연결 완료 후 renderer 상태 재확인
            if (remoteStream != null) {
              remoteRenderer.srcObject = remoteStream;
            }
            break;
          case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
          case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
          case RTCPeerConnectionState.RTCPeerConnectionStateFailed:
            debugPrint('[ViewModel] Connection lost or failed: $state');
            if (_state.screenState == AppScreenState.inCall) {
              await hangUp();
            }
            break;
          default:
            break;
        }
      };

      // 4. ICE Connection State 리스너
      peerConnection.onIceConnectionState = (RTCIceConnectionState state) {
        debugPrint('[ViewModel] ICE Connection state: $state');

        // ICE 연결 완료 시에도 한번 더 체크
        if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            debugPrint('[ViewModel] ICE Connected - Final renderer check');
            if (remoteRenderer.srcObject != null) {
              debugPrint(
                '[ViewModel] Remote renderer has stream after ICE connection',
              );
            } else {
              debugPrint(
                '[ViewModel] WARNING: Remote renderer still null after ICE connection',
              );
            }
          });
        }
      };

      debugPrint('[ViewModel] Peer connection listeners setup completed');
    } catch (e) {
      debugPrint('[ViewModel] Error setting up peer connection listeners: $e');
    }
  }

  Future<void> toggleMicrophone() async {
    if (localStream != null) {
      final audioTrack = localStream!.getAudioTracks().firstOrNull;
      if (audioTrack != null) {
        audioTrack.enabled = !audioTrack.enabled;
        debugPrint(
          "[ViewModel] Local audio track enabled: ${audioTrack.enabled}",
        );
        notifyListeners();
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

  Future<void> _cleanupCall() async {
    debugPrint("[ViewModel] Cleaning up call resources.");

    // 스트림 구독 취소
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    // Peer connection 정리
    if (_peerConnection != null) {
      try {
        await _closePeerConnectionUseCase.call(
          _peerConnection!,
          localStream,
          localRenderer,
        );
      } catch (e) {
        debugPrint('[ViewModel] Error closing peer connection: $e');
      }
      _peerConnection = null;
    }

    // 미디어 스트림 정리
    if (localStream != null) {
      try {
        _turnOffMediaStreamUseCase.call(localStream!, localRenderer);
      } catch (e) {
        debugPrint('[ViewModel] Error turning off local stream: $e');
      }
      localStream = null;
    }

    if (remoteStream != null) {
      try {
        _turnOffMediaStreamUseCase.call(remoteStream!, remoteRenderer);
      } catch (e) {
        debugPrint('[ViewModel] Error turning off remote stream: $e');
      }
      remoteStream = null;
    }

    // 렌더러 정리
    try {
      localRenderer.srcObject = null;
      remoteRenderer.srcObject = null;
    } catch (e) {
      debugPrint('[ViewModel] Error clearing renderers: $e');
    }

    // Call view 팝
    if (_callViewContext != null && Navigator.canPop(_callViewContext!)) {
      Navigator.pop(_callViewContext!);
    }
    _callViewContext = null;

    // 시그널링 리스너 다시 설정
    _setupSignalingListeners();
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

    // 통화 종료 시그널 전송 (연결되어 있다면)
    if (_state.remotePeerId != null && _state.myId != null) {
      try {
        _hangUpCallUseCase.call(_state.myId!, _state.remotePeerId!);
      } catch (e) {
        debugPrint('[ViewModel] Error sending hang up signal: $e');
      }
    }

    // 구독 취소
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    // 시그널링 연결 해제
    try {
      _disconnectSignalingUseCase.call();
    } catch (e) {
      debugPrint('[ViewModel] Error disconnecting signaling: $e');
    }

    // 리소스 정리
    _cleanupCall();

    // 렌더러 해제
    try {
      localRenderer.dispose();
      remoteRenderer.dispose();
    } catch (e) {
      debugPrint('[ViewModel] Error disposing renderers: $e');
    }

    super.dispose();
  }
}

// Extension to add StreamSubscription to a list
extension StreamSubscriptionExtension<T> on StreamSubscription<T> {
  void addTo(List<StreamSubscription> subscriptions) {
    subscriptions.add(this);
  }
}

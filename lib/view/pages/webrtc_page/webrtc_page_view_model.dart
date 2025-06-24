// webrtc_page_view_model.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:kolibri_project/data/core/result.dart';
import 'package:kolibri_project/view/pages/webrtc_page/video_adjust.dart';
import 'package:kolibri_project/view/pages/webrtc_page/webrtc_page_state.dart';

import '../../../data/dtos/gesture_data.dart';
import '../../../data/dtos/joystick_data.dart';
import '../../../domain/repository/video_call_repository.dart';
import '../../../utils/simple_logger.dart';

class WebrtcPageViewModel extends ChangeNotifier {
  final VideoCallRepository _videoCallRepository;

  WebrtcPageViewModel({required VideoCallRepository videoCallRepository})
    : _videoCallRepository = videoCallRepository {
    init();
  }

  // 상태 및 WebRTC 객체
  WebrtcPageState _state = const WebrtcPageState();

  WebrtcPageState get state => _state;

  RTCPeerConnection? _peerConnection;
  RTCSessionDescription? _incomingOffer; // 수신된 offer 정보
  StreamSubscription? _hangUpSubscription; // 추가
  String? _incomingCallerId; // 전화를 건 사람의 ID
  String? _targetPeerId; // 타겟 피어 ID 추가
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  MediaStream? _localStream;

  RTCVideoRenderer get localRenderer => _localRenderer;

  RTCVideoRenderer get remoteRenderer => _remoteRenderer;

  final Matrix4 _remoteTransform = Matrix4.identity();
  final List<RTCIceCandidate> _pendingIceCandidates = [];

  Matrix4 get remoteTransform => _remoteTransform;

  Offset? _remoteJoystickPosition;

  Offset? get remoteJoystickPosition => _remoteJoystickPosition;

  bool _disposed = false;

  // StreamSubscriptions for repository events
  StreamSubscription? _offerSubscription;
  StreamSubscription? _answerSubscription;
  StreamSubscription? _iceCandidateSubscription;
  StreamSubscription? _peerJoinedSubscription;
  StreamSubscription? _joystickSubscription;
  StreamSubscription? _gestureSubscription;
  StreamSubscription? _disconnectSubscription;
  StreamSubscription? _userListSubscription;

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
    ],
  };

  // 내 ID 반환
  String? get myId => _videoCallRepository.socket?.id;

  @override
  void dispose() {
    _disposed = true;
    _disposeSubscriptions();
    _disposeWebRTC();
    _videoCallRepository.dispose();
    super.dispose();
  }

  void _disposeSubscriptions() {
    _offerSubscription?.cancel();
    _answerSubscription?.cancel();
    _iceCandidateSubscription?.cancel();
    _peerJoinedSubscription?.cancel();
    _joystickSubscription?.cancel();
    _gestureSubscription?.cancel();
    _disconnectSubscription?.cancel();
    _userListSubscription?.cancel();
    _hangUpSubscription?.cancel();
  }

  Future<void> _disposeWebRTC() async {
    await _peerConnection?.close();
    await _localStream?.dispose();
    await _localRenderer.dispose();
    await _remoteRenderer.dispose();
    _pendingIceCandidates.clear();
    _peerConnection = null;
    _localStream = null;
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  void _setState(WebrtcPageState newState) {
    _state = newState;
    notifyListeners();
  }

  // 타겟 피어 설정 메서드 추가
  void setTargetPeer(String peerId) {
    _targetPeerId = peerId;
    _videoCallRepository.setTargetPeer(peerId);
  }

  // 초기화 및 리스너 등록
  Future<void> init() async {
    try {
      // 렌더러 초기화
      await _localRenderer.initialize();
      await _remoteRenderer.initialize();

      // 리스너를 먼저 설정
      _setupRepositoryListeners();

      // Repository 연결
      final connectResult = await _videoCallRepository.connect("lobby");
      switch (connectResult) {
        case Success<void>():
          _setState(
            state.copyWith(screenState: AppScreenState.lobby, myId: myId),
          );
          break;
        case Error<void>():
          _setState(
            WebrtcPageState(
              screenState: AppScreenState.error,
              errorMessage: connectResult.message,
            ),
          );
      }
    } catch (e) {
      logger.info("초기화 실패: $e");
      _setState(
        WebrtcPageState(
          screenState: AppScreenState.error,
          errorMessage: "초기화 중 오류가 발생했습니다: $e",
        ),
      );
    }
  }

  void _setupRepositoryListeners() {
    // 사용자 목록 업데이트
    _userListSubscription = _videoCallRepository.onUserListUpdate.listen((
      users,
    ) {
      final filteredUsers = users.where((id) => id != myId).toList();
      _setState(state.copyWith(onlineUsers: filteredUsers));
      logger.info("사용자 목록 업데이트: $filteredUsers");
    }, onError: (error) => logger.info("사용자 목록 업데이트 오류: $error"));

    // Offer 수신 - 단순화된 처리
    _offerSubscription = _videoCallRepository.onOfferReceived.listen((offer) {
      _handleOfferReceived(offer.$1, offer.$2);
    }, onError: (error) => logger.info("Offer 수신 오류: $error"));

    // Answer 수신
    _answerSubscription = _videoCallRepository.onAnswerReceived.listen(
      (answer) => _handleAnswerReceived(answer),
      onError: (error) => logger.info("Answer 수신 오류: $error"),
    );

    // ICE Candidate 수신
    _iceCandidateSubscription = _videoCallRepository.onIceCandidateReceived
        .listen(
          (candidate) => _handleIceCandidateReceived(candidate),
          onError: (error) => logger.info("ICE Candidate 수신 오류: $error"),
        );

    // Peer 참여
    _peerJoinedSubscription = _videoCallRepository.onPeerJoined.listen(
      (_) => _handlePeerJoined(),
      onError: (error) => logger.info("Peer 참여 오류: $error"),
    );

    // 조이스틱 데이터 수신
    _joystickSubscription = _videoCallRepository.onJoystickDataReceived.listen(
      (joystickData) => _handleJoystickDataReceived(joystickData),
      onError: (error) => logger.info("조이스틱 데이터 수신 오류: $error"),
    );

    // 제스처 데이터 수신
    _gestureSubscription = _videoCallRepository.onGestureDataReceived.listen(
      (gestureData) => _handleGestureDataReceived(gestureData),
      onError: (error) => logger.info("제스처 데이터 수신 오류: $error"),
    );

    _hangUpSubscription = _videoCallRepository.onHangUpReceived.listen(
      (_) => hangUp(isRemoteHangUp: true),
      onError: (error) => logger.info("Hang Up 수신 오류: $error"),
    );

    // 연결 해제
    _disconnectSubscription = _videoCallRepository.onDisconnected.listen(
      (_) => _handleDisconnected(),
      onError: (error) => logger.info("연결 해제 오류: $error"),
    );
  }

  Future<bool> _initializeLocalMedia() async {
    try {
      _localStream = await navigator.mediaDevices.getUserMedia({
        'audio': true,
        'video': {
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
          'facingMode': 'user',
        },
      });
      _localRenderer.srcObject = _localStream;
      return true;
    } catch (e) {
      logger.info("로컬 미디어 스트림 초기화 실패: $e");
      _setState(state.copyWith(errorMessage: "통화를 위해 카메라와 마이크 권한을 허용해주세요."));
      return false;
    }
  }

  // PeerConnection 생성 메서드 추가
  Future<void> _createPeerConnection() async {
    try {
      _peerConnection = await createPeerConnection(_iceServers);

      // 로컬 스트림 추가
      if (_localStream != null) {
        _localStream!.getTracks().forEach((track) {
          _peerConnection!.addTrack(track, _localStream!);
        });
      }

      // 리모트 스트림 수신 처리
      _peerConnection!.onTrack = (RTCTrackEvent event) {
        if (event.streams.isNotEmpty) {
          _remoteRenderer.srcObject = event.streams[0];
          notifyListeners();
        }
      };

      // ICE Candidate 처리
      _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
        _videoCallRepository.sendIceCandidate(candidate);
      };

      // 연결 상태 변화 처리
      _peerConnection!.onConnectionState = (RTCPeerConnectionState state) {
        logger.info("PeerConnection 상태: $state");
        // P2P 연결이 성공적으로 수립되었을 때 inCall 상태로 전환
        if (state == RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
          _setState(_state.copyWith(screenState: AppScreenState.inCall));
          logger.info("P2P 연결 성공. 통화 화면으로 전환합니다.");
        }
        // P2P 연결이 끊어지거나 실패했을 때 통화 종료
        else if (state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
            state == RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
          hangUp(isRemoteHangUp: true);
        }
      };

      logger.info("PeerConnection 생성 완료");
    } catch (e) {
      logger.info("PeerConnection 생성 실패: $e");
      throw Exception("PeerConnection 생성에 실패했습니다: $e");
    }
  }

  // --- 1. 통화 걸기 ---
  Future<void> callUser(String peerId) async {
    try {
      _setState(state.copyWith(screenState: AppScreenState.calling, remotePeerId: peerId));

      // 타겟 피어 설정 (Repository에도 설정)
      setTargetPeer(peerId);

      // 1. 권한 획득 및 미디어 초기화
      final mediaInitialized = await _initializeLocalMedia();
      if (!mediaInitialized) {
        logger.info("미디어 초기화 실패. 통화를 시작하지 않습니다.");
        _setState(state.copyWith(screenState: AppScreenState.lobby));
        return;
      }

      // 2. PeerConnection 생성
      await _createPeerConnection();

      // 3. Offer 생성 및 전송
      final offer = await _peerConnection!.createOffer();
      offer.sdp = preferH264(offer.sdp!);
      await _peerConnection!.setLocalDescription(offer);

      // 4. 발신자 정보를 포함해서 전송
      final sendResult = await _videoCallRepository.sendOfferWithCaller(
        offer,
        peerId,
      );
      switch (sendResult) {
        case Success<void>():
          logger.info("통화 요청을 $peerId에게 전송했습니다.");
          break;
        case Error<void>():
          throw Exception("Offer 전송 실패: ${sendResult.message}");
      }
    } catch (e) {
      logger.info("통화 걸기 실패: $e");
      _setState(
        state.copyWith(
          screenState: AppScreenState.error,
          errorMessage: "통화 연결에 실패했습니다: $e",
        ),
      );
    }
  }

  // --- 2. Offer 수신 처리 - 단순화 ---
  void _handleOfferReceived(RTCSessionDescription offer, String callerId) {
    try {
      logger.info("Offer 수신됨 from: $callerId");

      _incomingOffer = offer;
      _incomingCallerId = callerId; // [수정] 전달받은 callerId를 직접 사용

      _setState(
        state.copyWith(
          screenState: AppScreenState.incomingCall,
          incomingCallerId: _incomingCallerId,
        ),
      );

      logger.info("통화 요청을 $_incomingCallerId 로부터 받았습니다."); // 이제 정상적인 ID가 출력됨
    } catch (e) {
      logger.info("Offer 처리 실패: $e");
      _setState(
        state.copyWith(
          screenState: AppScreenState.error,
          errorMessage: "통화 요청 처리 중 오류가 발생했습니다: $e",
        ),
      );
    }
  }

  // --- 3. 수신 동의 (Answer 전송) ---
  Future<void> acceptIncomingCall() async {
    try {
      final offer = _incomingOffer;
      final callerId = _incomingCallerId;

      if (offer == null || callerId == null) {
        logger.info("수신할 Offer 또는 발신자 정보가 없습니다.");
        return;
      }

      _setState(state.copyWith(screenState: AppScreenState.connecting));

      // 1. 권한 획득 및 미디어 초기화
      final mediaInitialized = await _initializeLocalMedia();
      if (!mediaInitialized) {
        logger.info("미디어 초기화 실패. 통화를 수락하지 않습니다.");
        refuseIncomingCall();
        return;
      }

      // 2. PeerConnection 생성
      await _createPeerConnection();

      // 3. Remote Description 설정
      await _peerConnection!.setRemoteDescription(offer);

      // [추가] PeerConnection이 준비되기 전에 수신된 ICE Candidate들을 추가
      for (final candidate in _pendingIceCandidates) {
        await _peerConnection!.addCandidate(candidate);
        logger.info("임시 저장된 ICE Candidate 추가됨");
      }
      _pendingIceCandidates.clear();

      // 4. Answer 생성 및 전송
      final answer = await _peerConnection!.createAnswer();
      answer.sdp = preferH264(answer.sdp!);
      await _peerConnection!.setLocalDescription(answer);
      final sendResult = await _videoCallRepository.sendAnswer(answer);
      switch (sendResult) {
        case Success<void>():
          logger.info("Answer를 전송했습니다. P2P 연결을 기다립니다.");
          break;
        case Error<void>():
          throw Exception("Answer 전송 실패: ${sendResult.message}");
      }
    } catch (e) {
      logger.info("통화 수락 실패: $e");
      _setState(
        state.copyWith(
          screenState: AppScreenState.error,
          errorMessage: "통화 수락에 실패했습니다: $e",
        ),
      );
    }
  }

  // --- 4. 수신 거절 ---
  void refuseIncomingCall() {
    try {
      final callerId = _incomingCallerId;

      // 거절 신호를 서버에 전송 (선택사항)
      if (callerId != null) {
        _videoCallRepository.sendCallRefusal(callerId);
      }

      _incomingOffer = null;
      _incomingCallerId = null;
      _setState(
        state.copyWith(
          screenState: AppScreenState.lobby,
          remotePeerId: null,
          incomingCallerId: null,
        ),
      );
      logger.info("통화를 거절했습니다.");
    } catch (e) {
      logger.info("통화 거절 처리 실패: $e");
    }
  }

  // --- 5. Answer 수신 처리 ---
  void _handleAnswerReceived(RTCSessionDescription answer) async {
    try {
      await _peerConnection?.setRemoteDescription(answer);
      logger.info("Answer를 받았습니다. P2P 연결을 기다립니다.");
    } catch (e) {
      logger.info("Answer 처리 실패: $e");
      _setState(
        state.copyWith(
          screenState: AppScreenState.error,
          errorMessage: "Answer 처리 중 오류 발생: $e",
        ),
      );
    }
  }

  // --- ICE Candidate 처리 ---
  // [수정] ICE Candidate를 PeerConnection 상태에 따라 다르게 처리
  void _handleIceCandidateReceived(RTCIceCandidate candidate) {
    try {
      if (_peerConnection?.connectionState != null) {
        _peerConnection?.addCandidate(candidate);
        logger.info("ICE Candidate 추가됨");
      } else {
        // PeerConnection이 아직 준비되지 않았으면 임시 저장
        _pendingIceCandidates.add(candidate);
        logger.info("ICE Candidate 임시 저장됨 (PeerConnection 준비 전)");
      }
    } catch (e) {
      logger.info("ICE Candidate 처리 실패: $e");
    }
  }

  // --- Peer 참여 처리 ---
  void _handlePeerJoined() {
    logger.info("새로운 피어가 참여했습니다.");
  }

  // --- 조이스틱 데이터 수신 처리 ---
  void _handleJoystickDataReceived(JoystickData joystickData) {
    _remoteJoystickPosition = Offset(
      joystickData.dx ?? 0.0,
      joystickData.dy ?? 0.0,
    );
    notifyListeners();
  }

  // --- 제스처 데이터 수신 처리 ---
  void _handleGestureDataReceived(GestureData gestureData) {
    // 제스처 데이터로 화면 변환 업데이트
    _remoteTransform.setIdentity();
    _remoteTransform.translate(gestureData.dx ?? 0.0, gestureData.dy ?? 0.0);
    _remoteTransform.scale(gestureData.scale ?? 1.0);
    notifyListeners();
  }

  // --- 연결 해제 처리 ---
  void _handleDisconnected() {
    _setState(
      state.copyWith(
        screenState: AppScreenState.error,
        errorMessage: "서버와 연결이 끊어졌습니다.",
      ),
    );
  }

  // --- 조이스틱 데이터 전송 메서드 추가 ---
  Future<void> sendJoystickData(Offset position) async {
    final joystickData = JoystickData(dx: position.dx, dy: position.dy);
    await _videoCallRepository.sendJoystickData(joystickData);
  }

  // --- 제스처 데이터 전송 메서드 추가 ---
  Future<void> sendGestureData({
    required double dx,
    required double dy,
    required double scale,
  }) async {
    final gestureData = GestureData(dx: dx, dy: dy, scale: scale);
    await _videoCallRepository.sendGestureData(gestureData);
  }

  // --- 6. 통화 종료 ---
  Future<void> hangUp({bool isRemoteHangUp = false}) async {
    try {
      // 내가 끊는 경우에만 상대에게 신호 전송
      if (!isRemoteHangUp && state.remotePeerId != null) {
        await _videoCallRepository.sendHangUp(state.remotePeerId!);
      }
      // PeerConnection 정리
      await _peerConnection?.close();
      _peerConnection = null;

      // LocalStream 정리
      await _localStream?.dispose();
      _localStream = null;

      // 렌더러 정리 후 재초기화
      _localRenderer.srcObject = null;
      _remoteRenderer.srcObject = null;

      // 상태 초기화
      _incomingOffer = null;
      _incomingCallerId = null;
      _targetPeerId = null;
      _remoteJoystickPosition = null;
      _remoteTransform.setIdentity();
      _pendingIceCandidates.clear();

      _setState(
        state.copyWith(
          screenState: AppScreenState.lobby,
          remotePeerId: null,
          incomingCallerId: null,
          errorMessage: null,
        ),
      );

      logger.info("통화가 종료되었습니다.");
    } catch (e) {
      logger.info("통화 종료 처리 실패: $e");
      _setState(
        state.copyWith(
          screenState: AppScreenState.error,
          errorMessage: "통화 종료 중 오류가 발생했습니다: $e",
        ),
      );
    }
  }
}

// video_call_data_source.dart

import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../env/env.dart';
import '../../utils/simple_logger.dart';

// StreamController를 사용하여 콜백을 스트림으로 변환합니다.
class VideoCallDataSource {
  io.Socket? socket;
  String? _currentRoomId;
  bool _isDisposed = false;

  // 각 이벤트에 대한 StreamController 생성 (broadcast로 여러 곳에서 수신 가능)
  final _onOfferController = StreamController<Map<String, dynamic>>.broadcast();
  final _onAnswerController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _onIceCandidateController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _onPeerJoinedController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _onSignalController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _onDisconnectController = StreamController<void>.broadcast();
  final _onUserListController = StreamController<List<String>>.broadcast();
  final _onCallRefusedController = StreamController<void>.broadcast(); // 추가
  final _onHangUpController = StreamController<void>.broadcast(); // 추가

  // Controller의 Stream을 외부로 노출
  Stream<Map<String, dynamic>> get onOffer => _onOfferController.stream;

  Stream<Map<String, dynamic>> get onAnswer => _onAnswerController.stream;

  Stream<Map<String, dynamic>> get onIceCandidate =>
      _onIceCandidateController.stream;

  Stream<Map<String, dynamic>> get onPeerJoined =>
      _onPeerJoinedController.stream;

  Stream<Map<String, dynamic>> get onSignal => _onSignalController.stream;

  Stream<void> get onDisconnect => _onDisconnectController.stream;

  Stream<List<String>> get onUserListUpdate => _onUserListController.stream;

  Stream<void> get onCallRefused => _onCallRefusedController.stream; // 추가
  Stream<void> get onHangUpReceived => _onHangUpController.stream; // 추가

  // [수정] Completer를 사용하여 비동기 연결을 안정적으로 처리
  Future<void> connect() {
    final completer = Completer<void>();

    if (socket?.connected == true) {
      logger.info('Socket is already connected.');
      completer.complete();
      return completer.future;
    }

    // Socket.IO 클라이언트 초기화
    socket = io.io(
      Env.kolibriServerAddress,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    // 이벤트 리스너 등록
    socket!.onConnect((_) {
      logger.info('Socket connected: ${socket!.id}');
      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    socket!.onConnectError((error) {
      logger.info('Socket connection error: $error');
      if (!completer.isCompleted) {
        completer.completeError(Exception('Connection Error: $error'));
      }
    });

    socket!.onError((error) {
      logger.info('Socket error: $error');
      if (!completer.isCompleted) {
        // 연결 단계에서의 오류만 completer로 처리
        if (socket?.connected != true) {
          completer.completeError(Exception('Socket Error: $error'));
        }
      }
    });

    // 실제 이벤트 처리 로직
    _registerEventHandlers();

    // 연결 시도
    socket!.connect();

    return completer.future;
  }

  void _registerEventHandlers() {
    socket!.on('private-offer', (data) {
      if (_isDisposed) return;
      logger.info('Received private-offer: $data');
      _onOfferController.add(data);
    });

    socket!.on('private-answer', (data) {
      if (_isDisposed) return;
      logger.info('Received private-answer: $data');
      _onAnswerController.add(data);
    });

    socket!.on('private-ice-candidate', (data) {
      if (_isDisposed) return;
      logger.info('Received private-ice-candidate: $data');
      _onIceCandidateController.add(data);
    });

    socket!.on('update-user-list', (data) {
      if (_isDisposed) return;
      logger.info('Received update-user-list: $data');
      if (data is List) {
        final userList = data.cast<String>();
        _onUserListController.add(userList);
      }
    });

    socket!.on('peer-joined', (data) {
      if (_isDisposed) return;
      logger.info('Received peer-joined: $data');
      _onPeerJoinedController.add(data);
    });

    socket!.on('signal', (data) {
      if (_isDisposed) return;
      logger.info('Received signal: $data');
      _onSignalController.add(data);
    });

    socket!.on('call-refused', (data) {
      if (_isDisposed) return;
      // 추가
      logger.info('Call refused: $data');
      _onCallRefusedController.add(null);
    });

    socket!.on('peer-disconnected', (data) {
      if (_isDisposed) return;
      logger.info('Peer disconnected: $data');
      // 필요에 따라 처리
    });

    socket!.on('hang-up', (data) {
      if (_isDisposed) return;
      logger.info('Received hang-up: $data');
      _onHangUpController.add(null);
    });

    socket!.onDisconnect((_) {
      if (_isDisposed) return;
      logger.info('Socket disconnected');
      _onDisconnectController.add(null);
    });
  }

  // 방 참여
  void joinRoom(String roomId) {
    if (socket?.connected == true) {
      _currentRoomId = roomId;
      socket!.emit('join', roomId);
      logger.info('Joined room: $roomId');
    } else {
      logger.info('Cannot join room, socket not connected.');
    }
  }

  // 각종 WebRTC 시그널 및 제스처 시그널 전송
  void sendSignal(String event, Map<String, dynamic> data) {
    if (socket?.connected == true) {
      socket!.emit(event, data);
      logger.info('Sent $event: $data');
    } else {
      logger.info('Socket not connected. Cannot send $event');
    }
  }

  // 현재 룸 ID 반환
  String? get currentRoom => _currentRoomId;

  // 연결 상태 확인
  bool get isConnected => socket?.connected ?? false;

  // 리소스 정리 (모든 StreamController를 닫아 메모리 누수 방지)
  void dispose() {
    if (_isDisposed) return; // 이미 dispose 되었다면 중복 실행 방지
    _isDisposed = true;
    _onOfferController.close();
    _onAnswerController.close();
    _onIceCandidateController.close();
    _onPeerJoinedController.close();
    _onSignalController.close();
    _onDisconnectController.close();
    _onUserListController.close();
    _onCallRefusedController.close(); // 추가
    _onHangUpController.close();
    socket?.dispose();
  }
}

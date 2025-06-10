import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kolibri_project/data/dtos/call_answer_dto.dart';
import 'package:kolibri_project/data/dtos/call_offer_dto.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// DTO 파일 경로가 올바른지 확인하세요.
// 예시 경로이므로 실제 프로젝트 구조에 맞게 수정해야 할 수 있습니다.
import '../../dtos/control_signal_dto.dart';
import '../../dtos/ice_candidate_dto.dart';

class SocketDataSource {
  io.Socket? _socket;
  String? _currentUserId;

  String? get currentUserId => _currentUserId;

  // Streams for various events
  final _userListController = StreamController<List<String>>.broadcast();
  final _offerController = StreamController<CallOfferDto>.broadcast();
  final _answerController = StreamController<CallAnswerDto>.broadcast();
  final _iceCandidateController = StreamController<IceCandidateDto>.broadcast();
  final _hangUpController = StreamController<String>.broadcast(); // fromId
  final _refusalController = StreamController<String>.broadcast(); // fromId
  final _controlSignalController =
      StreamController<ControlSignalDto>.broadcast();
  final _connectionStatusController =
      StreamController<bool>.broadcast(); // true for connected

  Stream<List<String>> get userListStream => _userListController.stream;

  Stream<CallOfferDto> get offerStream => _offerController.stream;

  Stream<CallAnswerDto> get answerStream => _answerController.stream;

  Stream<IceCandidateDto> get iceCandidateStream =>
      _iceCandidateController.stream;

  Stream<String> get hangUpStream => _hangUpController.stream;

  Stream<String> get refusalStream => _refusalController.stream;

  Stream<ControlSignalDto> get controlSignalStream =>
      _controlSignalController.stream;

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  Future<String> connect(String url) async {
    final Completer<String> completer = Completer<String>();
    try {
      _socket = io.io(
        url,
        io.OptionBuilder().setTransports(['websocket']).build(),
      );

      _socket!.onConnect((_) {
        _currentUserId = _socket!.id;
        debugPrint('[SocketDataSource] Connected: $_currentUserId');
        _connectionStatusController.add(true);
        if (!completer.isCompleted) {
          completer.complete(_currentUserId!);
        }
      });

      _socket!.onConnectError((data) {
        debugPrint('[SocketDataSource] Connect Error: $data');
        _connectionStatusController.add(false);
        if (!completer.isCompleted) {
          completer.completeError("Socket connection error: $data");
        }
      });

      _socket!.onError((data) {
        debugPrint('[SocketDataSource] Error: $data');
        _connectionStatusController.add(false);
        if (!completer.isCompleted) {
          completer.completeError("Socket error: $data");
        }
      });

      _socket!.onDisconnect((data) {
        debugPrint('[SocketDataSource] Disconnected: $data');
        _connectionStatusController.add(false);
      });

      // 유저 리스트 업데이트 수신 - 서버에서 보내는 구조에 맞게 수정
      _socket!.on('updateUserlist', (data) {
        debugPrint('[SocketDataSource] Received userlist update: $data');
        if (data is Map<String, dynamic> && data['userList'] != null) {
          final List<String> users = (data['userList'] as List<dynamic>)
              .map((e) => e.toString())
              .where((userId) => userId != _currentUserId) // 본인 제외
              .toList();
          _userListController.add(users);
        }
      });

      // Offer 수신
      _socket!.on('offer', (rawData) {
        debugPrint('[SocketDataSource] Received offer');
        if (rawData is Map<String, dynamic>) {
          try {
            _offerController.add(CallOfferDto.fromJson(rawData));
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing offer: $e, data: $rawData',
            );
          }
        }
      });

      // Answer 수신
      _socket!.on('answer', (rawData) {
        debugPrint('[SocketDataSource] Received answer');
        if (rawData is Map<String, dynamic>) {
          try {
            _answerController.add(CallAnswerDto.fromJson(rawData));
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing answer: $e, data: $rawData',
            );
          }
        }
      });

      // ICE Candidate 수신
      _socket!.on('remoteIceCandidate', (rawData) {
        debugPrint('[SocketDataSource] Received ICE candidate: $rawData');
        if (rawData is Map<String, dynamic>) {
          try {
            _iceCandidateController.add(IceCandidateDto.fromJson(rawData));
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing iceCandidate: $e, data: $rawData',
            );
          }
        }
      });

      // 통화 종료 수신 - 서버의 disconnectPeer 이벤트에 맞춤
      _socket!.on('disconnectPeer', (rawData) {
        debugPrint('[SocketDataSource] Received disconnectPeer: $rawData');
        if (rawData is Map<String, dynamic> && rawData.containsKey('from')) {
          _hangUpController.add(rawData['from'].toString());
        } else {
          debugPrint(
            '[SocketDataSource] disconnectPeer event received with invalid data: $rawData',
          );
        }
      });

      // 통화 거절 수신
      _socket!.on('refuse', (rawData) {
        debugPrint('[SocketDataSource] Received refuse: $rawData');
        if (rawData is Map<String, dynamic> && rawData.containsKey('from')) {
          _refusalController.add(rawData['from'].toString());
        } else {
          debugPrint(
            '[SocketDataSource] refuse event received with invalid data: $rawData',
          );
        }
      });

      // Control Signal 수신
      _socket!.on('controlSignal', (rawData) {
        debugPrint('[SocketDataSource] Received controlSignal: $rawData');
        if (rawData is Map<String, dynamic>) {
          try {
            _controlSignalController.add(ControlSignalDto.fromJson(rawData));
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing controlSignal: $e, data: $rawData',
            );
          }
        } else {
          debugPrint(
            '[SocketDataSource] controlSignal event received with invalid data: $rawData',
          );
        }
      });

      // 수동으로 연결 시작
      _socket!.connect();
    } catch (e) {
      debugPrint('[SocketDataSource] Exception during socket setup: $e');
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
    }

    return completer.future;
  }

  // 사용자 목록을 서버에 요청하는 메서드
  void requestUserList() {
    emit('requestUserList', null); // 데이터 없이 이벤트 이름만 보냅니다.
  }

  // Offer 전송 - 서버가 기대하는 필드명 사용
  void sendOffer(CallOfferDto offer) {
    if (_socket?.connected == true) {
      final data = offer.toJson();
      _socket!.emit('offer', data);
      debugPrint('[SocketDataSource] Sent offer');
    } else {
      debugPrint('[SocketDataSource] Cannot send offer, socket not connected.');
    }
  }

  // Answer 전송 - 서버가 기대하는 필드명 사용
  void sendAnswer(CallAnswerDto answer) {
    if (_socket?.connected == true) {
      final data = answer.toJson();
      _socket!.emit('answer', data);
      debugPrint('[SocketDataSource] Sent answer');
    } else {
      debugPrint(
        '[SocketDataSource] Cannot send answer, socket not connected.',
      );
    }
  }

  // ICE Candidate 전송 - 서버가 기대하는 필드명 사용
  void sendIceCandidate(IceCandidateDto candidate) {
    if (_socket?.connected == true) {
      final data = {
        'from': _currentUserId,
        'to': candidate.to,
        'candidate': candidate.candidate,
      };
      _socket!.emit('remoteIceCandidate', data);
      debugPrint('[SocketDataSource] Sent ICE candidate: $data');
    } else {
      debugPrint(
        '[SocketDataSource] Cannot send ICE candidate, socket not connected.',
      );
    }
  }

  // 통화 거절 전송
  void sendRefuse(String toId, {String? reason}) {
    if (_socket?.connected == true) {
      final data = {'to': toId, 'reason': reason};
      _socket!.emit('refuse', data);
      debugPrint('[SocketDataSource] Sent refuse: $data');
    } else {
      debugPrint(
        '[SocketDataSource] Cannot send refuse, socket not connected.',
      );
    }
  }

  // 통화 종료 전송
  void sendDisconnectPeer(String toId) {
    if (_socket?.connected == true) {
      final data = {'to': toId};
      _socket!.emit('disconnectPeer', data);
      debugPrint('[SocketDataSource] Sent disconnectPeer: $data');
    } else {
      debugPrint(
        '[SocketDataSource] Cannot send disconnectPeer, socket not connected.',
      );
    }
  }

  // Control Signal 전송
  void sendControlSignal(ControlSignalDto signal) {
    if (_socket?.connected == true) {
      final data = {
        'from': _currentUserId,
        'to': signal.to,
        'signal':
            '${signal.type}: ${signal.dx}, ${signal.dy}, ${signal.angle}, ${signal.scale}',
      };
      _socket!.emit('controlSignal', data);
      debugPrint('[SocketDataSource] Sent controlSignal: $data');
    } else {
      debugPrint(
        '[SocketDataSource] Cannot send controlSignal, socket not connected.',
      );
    }
  }

  // 범용 emit 메서드 (기존 코드와의 호환성을 위해 유지)
  void emit(String event, dynamic data) {
    if (_socket?.connected == true) {
      _socket!.emit(event, data);
      debugPrint('[SocketDataSource] Emitted $event: $data');
    } else {
      debugPrint(
        '[SocketDataSource] Cannot emit $event, socket not connected.',
      );
    }
  }

  void dispose() {
    _userListController.close();
    _offerController.close();
    _answerController.close();
    _iceCandidateController.close();
    _hangUpController.close();
    _refusalController.close();
    _controlSignalController.close();
    _connectionStatusController.close();
    _socket?.disconnect();
    _socket?.dispose();
  }
}

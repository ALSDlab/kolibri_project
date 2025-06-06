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

  Future<String?> connect(String serverUrl) async {
    if (_socket?.connected == true) {
      _connectionStatusController.add(true);
      return _currentUserId;
    }
    final Completer<String?> completer = Completer<String?>();

    try {
      print('connecting.....${serverUrl}');
      _socket = io.io(
        serverUrl,
        io.OptionBuilder()
            .setTransports([
              'websocket',
            ]) // 웹소켓만 사용. 연결 문제 시 ['polling', 'websocket'] 등으로 테스트해볼 수 있음.
            .disableAutoConnect() // onConnect 전에 리스너를 설정하기 위해 자동 연결 비활성화
            .build(),
      );

      // 이벤트 리스너 설정
      _socket!.onConnect((_) {
        _currentUserId = _socket!.id;
        _connectionStatusController.add(true);
        debugPrint('[SocketDataSource] Connected: $_currentUserId');
        if (!completer.isCompleted) completer.complete(_currentUserId);
      });

      _socket!.onConnectError((data) {
        _connectionStatusController.add(false);
        debugPrint('[SocketDataSource] Connect Error: $data');
        if (!completer.isCompleted) {
          completer.completeError(Exception("Connection Error: $data"));
        }
      });

      _socket!.onError((data) {
        // 이 onError는 연결 후 발생하는 일반적인 소켓 오류를 처리할 수 있습니다.
        debugPrint('[SocketDataSource] Error: $data');
        // 필요에 따라 _connectionStatusController.add(false) 또는 다른 오류 처리 로직 추가
      });

      _socket!.onDisconnect((data) {
        _connectionStatusController.add(false);
        debugPrint('[SocketDataSource] Disconnected: $data');
        _currentUserId = null;
      });

      _socket!.on('updateUserlist', (rawData) {
        if (rawData is Map<String, dynamic> && rawData['userList'] != null) {
          try {
            List<String> users = List<String>.from(rawData['userList']);
            _userListController.add(users);
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing userList: $e, data: $rawData',
            );
          }
        } else {
          debugPrint(
            '[SocketDataSource] updateUserlist event received with invalid data: $rawData',
          );
        }
      });

      _socket!.on('offer', (rawData) {
        if (rawData is Map<String, dynamic>) {
          try {
            _offerController.add(CallOfferDto.fromJson(rawData));
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing offer: $e, data: $rawData',
            );
          }
        } else {
          debugPrint(
            '[SocketDataSource] offer event received with invalid data: $rawData',
          );
        }
      });

      _socket!.on('answer', (rawData) {
        if (rawData is Map<String, dynamic>) {
          try {
            _answerController.add(CallAnswerDto.fromJson(rawData));
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing answer: $e, data: $rawData',
            );
          }
        } else {
          debugPrint(
            '[SocketDataSource] answer event received with invalid data: $rawData',
          );
        }
      });

      _socket!.on('remoteIceCandidate', (rawData) {
        if (rawData is Map<String, dynamic>) {
          try {
            _iceCandidateController.add(IceCandidateDto.fromJson(rawData));
          } catch (e) {
            debugPrint(
              '[SocketDataSource] Error parsing remoteIceCandidate: $e, data: $rawData',
            );
          }
        } else {
          debugPrint(
            '[SocketDataSource] remoteIceCandidate event received with invalid data: $rawData',
          );
        }
      });

      _socket!.on('disconnectPeer', (rawData) {
        if (rawData is Map<String, dynamic> &&
            rawData.containsKey('from') &&
            rawData['from'] is String) {
          _hangUpController.add(rawData['from'] as String);
        } else {
          debugPrint(
            '[SocketDataSource] disconnectPeer event received with invalid data: $rawData',
          );
        }
      });

      _socket!.on('refuse', (rawData) {
        if (rawData is Map<String, dynamic> &&
            rawData.containsKey('from') &&
            rawData['from'] is String) {
          _refusalController.add(rawData['from'] as String);
          // rawData['reason'] 등을 활용하여 UI에 거절 사유 표시 가능
        } else {
          debugPrint(
            '[SocketDataSource] refuse event received with invalid data: $rawData',
          );
        }
      });

      _socket!.on('controlSignal', (rawData) {
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
    _socket?.dispose();
    debugPrint('[SocketDataSource] Disposed');
  }
}

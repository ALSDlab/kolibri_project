import 'package:freezed_annotation/freezed_annotation.dart';

part 'webrtc_page_state.freezed.dart';
part 'webrtc_page_state.g.dart';

// 앱의 전체 화면 상태를 나타내는 Enum
enum AppScreenState {
  initial, // 초기 로딩 상태
  lobby, // 로비 (사용자 목록 표시)
  calling,
  connecting,
  incomingCall, // 전화 수신 중인 상태
  inCall, // 통화 중인 상태
  error, // 에러 발생 상태
}

@freezed
abstract class WebrtcPageState with _$WebrtcPageState {
  const factory WebrtcPageState({
    @Default(AppScreenState.initial) AppScreenState screenState,
    String? myId,
    @Default([]) List<String> onlineUsers,
    String? remotePeerId, // 현재 통화 중인 상대방 ID
    String? incomingCallerId, // 전화를 건 사람의 ID
    String? errorMessage,
  }) = _WebrtcPageState;

  factory WebrtcPageState.fromJson(Map<String, dynamic> json) =>
      _$WebrtcPageStateFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kolibri_project/domain/model/call_answer_model.dart';

import '../../../domain/model/call_offer_model.dart';
import '../../../domain/model/control_signal_model.dart';
import '../../../domain/model/peer_user_model.dart';

part 'webrtc_page_state.freezed.dart';
part 'webrtc_page_state.g.dart';

enum AppScreenState { initial, loading, lobby, incomingCall, inCall, error }

@freezed
abstract class WebrtcPageState with _$WebrtcPageState {
  const factory WebrtcPageState({
    @Default(AppScreenState.initial) AppScreenState screenState,
    @Default([]) List<PeerUserModel> onlineUsers,
    String? myId,
    String? remotePeerId, // Current peer in call or being called
    PeerUserModel? selectedUserForCall, // User selected from lobby
    ControlSignalModel? lastReceivedControlSignal,
    @Default(false) bool localVideoEnabled, // Indicates if local video is ON
    @Default(false)
    bool remoteVideoVisible, // Indicates if remote video is received and ON
    CallOfferModel? incomingOffer,
    CallAnswerModel? comingCallAnswer,
    @Default(false) bool audioOnlyCall, // Indicates if the call is audio-only

    String? errorMessage,
  }) = _WebrtcPageState;

  factory WebrtcPageState.fromJson(Map<String, dynamic> json) =>
      _$WebrtcPageStateFromJson(json);
}

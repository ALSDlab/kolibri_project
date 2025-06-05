import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/call_offer_model.dart';
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
    @Default(false) bool localVideoEnabled,
    @Default(false) bool remoteVideoVisible,
    CallOfferModel? incomingOffer,
    @Default(false) bool audioOnlyCall,
    String? errorMessage,
  }) = _WebrtcPageState;

  factory WebrtcPageState.fromJson(Map<String, dynamic> json) =>
      _$WebrtcPageStateFromJson(json);
}

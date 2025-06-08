// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'webrtc_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebrtcPageState {

 AppScreenState get screenState; List<PeerUserModel> get onlineUsers; String? get myId; String? get remotePeerId;// Current peer in call or being called
 PeerUserModel? get selectedUserForCall;// User selected from lobby
 ControlSignalModel? get lastReceivedControlSignal; bool get localVideoEnabled;// Indicates if local video is ON
 bool get remoteVideoVisible;// Indicates if remote video is received and ON
 CallOfferModel? get incomingOffer; CallAnswerModel? get comingCallAnswer; bool get audioOnlyCall;// Indicates if the call is audio-only
 String? get errorMessage;
/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebrtcPageStateCopyWith<WebrtcPageState> get copyWith => _$WebrtcPageStateCopyWithImpl<WebrtcPageState>(this as WebrtcPageState, _$identity);

  /// Serializes this WebrtcPageState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebrtcPageState&&(identical(other.screenState, screenState) || other.screenState == screenState)&&const DeepCollectionEquality().equals(other.onlineUsers, onlineUsers)&&(identical(other.myId, myId) || other.myId == myId)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.selectedUserForCall, selectedUserForCall) || other.selectedUserForCall == selectedUserForCall)&&(identical(other.lastReceivedControlSignal, lastReceivedControlSignal) || other.lastReceivedControlSignal == lastReceivedControlSignal)&&(identical(other.localVideoEnabled, localVideoEnabled) || other.localVideoEnabled == localVideoEnabled)&&(identical(other.remoteVideoVisible, remoteVideoVisible) || other.remoteVideoVisible == remoteVideoVisible)&&(identical(other.incomingOffer, incomingOffer) || other.incomingOffer == incomingOffer)&&(identical(other.comingCallAnswer, comingCallAnswer) || other.comingCallAnswer == comingCallAnswer)&&(identical(other.audioOnlyCall, audioOnlyCall) || other.audioOnlyCall == audioOnlyCall)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenState,const DeepCollectionEquality().hash(onlineUsers),myId,remotePeerId,selectedUserForCall,lastReceivedControlSignal,localVideoEnabled,remoteVideoVisible,incomingOffer,comingCallAnswer,audioOnlyCall,errorMessage);

@override
String toString() {
  return 'WebrtcPageState(screenState: $screenState, onlineUsers: $onlineUsers, myId: $myId, remotePeerId: $remotePeerId, selectedUserForCall: $selectedUserForCall, lastReceivedControlSignal: $lastReceivedControlSignal, localVideoEnabled: $localVideoEnabled, remoteVideoVisible: $remoteVideoVisible, incomingOffer: $incomingOffer, comingCallAnswer: $comingCallAnswer, audioOnlyCall: $audioOnlyCall, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $WebrtcPageStateCopyWith<$Res>  {
  factory $WebrtcPageStateCopyWith(WebrtcPageState value, $Res Function(WebrtcPageState) _then) = _$WebrtcPageStateCopyWithImpl;
@useResult
$Res call({
 AppScreenState screenState, List<PeerUserModel> onlineUsers, String? myId, String? remotePeerId, PeerUserModel? selectedUserForCall, ControlSignalModel? lastReceivedControlSignal, bool localVideoEnabled, bool remoteVideoVisible, CallOfferModel? incomingOffer, CallAnswerModel? comingCallAnswer, bool audioOnlyCall, String? errorMessage
});


$PeerUserModelCopyWith<$Res>? get selectedUserForCall;$ControlSignalModelCopyWith<$Res>? get lastReceivedControlSignal;$CallOfferModelCopyWith<$Res>? get incomingOffer;$CallAnswerModelCopyWith<$Res>? get comingCallAnswer;

}
/// @nodoc
class _$WebrtcPageStateCopyWithImpl<$Res>
    implements $WebrtcPageStateCopyWith<$Res> {
  _$WebrtcPageStateCopyWithImpl(this._self, this._then);

  final WebrtcPageState _self;
  final $Res Function(WebrtcPageState) _then;

/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? screenState = null,Object? onlineUsers = null,Object? myId = freezed,Object? remotePeerId = freezed,Object? selectedUserForCall = freezed,Object? lastReceivedControlSignal = freezed,Object? localVideoEnabled = null,Object? remoteVideoVisible = null,Object? incomingOffer = freezed,Object? comingCallAnswer = freezed,Object? audioOnlyCall = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
screenState: null == screenState ? _self.screenState : screenState // ignore: cast_nullable_to_non_nullable
as AppScreenState,onlineUsers: null == onlineUsers ? _self.onlineUsers : onlineUsers // ignore: cast_nullable_to_non_nullable
as List<PeerUserModel>,myId: freezed == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String?,remotePeerId: freezed == remotePeerId ? _self.remotePeerId : remotePeerId // ignore: cast_nullable_to_non_nullable
as String?,selectedUserForCall: freezed == selectedUserForCall ? _self.selectedUserForCall : selectedUserForCall // ignore: cast_nullable_to_non_nullable
as PeerUserModel?,lastReceivedControlSignal: freezed == lastReceivedControlSignal ? _self.lastReceivedControlSignal : lastReceivedControlSignal // ignore: cast_nullable_to_non_nullable
as ControlSignalModel?,localVideoEnabled: null == localVideoEnabled ? _self.localVideoEnabled : localVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,remoteVideoVisible: null == remoteVideoVisible ? _self.remoteVideoVisible : remoteVideoVisible // ignore: cast_nullable_to_non_nullable
as bool,incomingOffer: freezed == incomingOffer ? _self.incomingOffer : incomingOffer // ignore: cast_nullable_to_non_nullable
as CallOfferModel?,comingCallAnswer: freezed == comingCallAnswer ? _self.comingCallAnswer : comingCallAnswer // ignore: cast_nullable_to_non_nullable
as CallAnswerModel?,audioOnlyCall: null == audioOnlyCall ? _self.audioOnlyCall : audioOnlyCall // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeerUserModelCopyWith<$Res>? get selectedUserForCall {
    if (_self.selectedUserForCall == null) {
    return null;
  }

  return $PeerUserModelCopyWith<$Res>(_self.selectedUserForCall!, (value) {
    return _then(_self.copyWith(selectedUserForCall: value));
  });
}/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ControlSignalModelCopyWith<$Res>? get lastReceivedControlSignal {
    if (_self.lastReceivedControlSignal == null) {
    return null;
  }

  return $ControlSignalModelCopyWith<$Res>(_self.lastReceivedControlSignal!, (value) {
    return _then(_self.copyWith(lastReceivedControlSignal: value));
  });
}/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallOfferModelCopyWith<$Res>? get incomingOffer {
    if (_self.incomingOffer == null) {
    return null;
  }

  return $CallOfferModelCopyWith<$Res>(_self.incomingOffer!, (value) {
    return _then(_self.copyWith(incomingOffer: value));
  });
}/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallAnswerModelCopyWith<$Res>? get comingCallAnswer {
    if (_self.comingCallAnswer == null) {
    return null;
  }

  return $CallAnswerModelCopyWith<$Res>(_self.comingCallAnswer!, (value) {
    return _then(_self.copyWith(comingCallAnswer: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _WebrtcPageState implements WebrtcPageState {
  const _WebrtcPageState({this.screenState = AppScreenState.initial, final  List<PeerUserModel> onlineUsers = const [], this.myId, this.remotePeerId, this.selectedUserForCall, this.lastReceivedControlSignal, this.localVideoEnabled = false, this.remoteVideoVisible = false, this.incomingOffer, this.comingCallAnswer, this.audioOnlyCall = false, this.errorMessage}): _onlineUsers = onlineUsers;
  factory _WebrtcPageState.fromJson(Map<String, dynamic> json) => _$WebrtcPageStateFromJson(json);

@override@JsonKey() final  AppScreenState screenState;
 final  List<PeerUserModel> _onlineUsers;
@override@JsonKey() List<PeerUserModel> get onlineUsers {
  if (_onlineUsers is EqualUnmodifiableListView) return _onlineUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_onlineUsers);
}

@override final  String? myId;
@override final  String? remotePeerId;
// Current peer in call or being called
@override final  PeerUserModel? selectedUserForCall;
// User selected from lobby
@override final  ControlSignalModel? lastReceivedControlSignal;
@override@JsonKey() final  bool localVideoEnabled;
// Indicates if local video is ON
@override@JsonKey() final  bool remoteVideoVisible;
// Indicates if remote video is received and ON
@override final  CallOfferModel? incomingOffer;
@override final  CallAnswerModel? comingCallAnswer;
@override@JsonKey() final  bool audioOnlyCall;
// Indicates if the call is audio-only
@override final  String? errorMessage;

/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebrtcPageStateCopyWith<_WebrtcPageState> get copyWith => __$WebrtcPageStateCopyWithImpl<_WebrtcPageState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebrtcPageStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebrtcPageState&&(identical(other.screenState, screenState) || other.screenState == screenState)&&const DeepCollectionEquality().equals(other._onlineUsers, _onlineUsers)&&(identical(other.myId, myId) || other.myId == myId)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.selectedUserForCall, selectedUserForCall) || other.selectedUserForCall == selectedUserForCall)&&(identical(other.lastReceivedControlSignal, lastReceivedControlSignal) || other.lastReceivedControlSignal == lastReceivedControlSignal)&&(identical(other.localVideoEnabled, localVideoEnabled) || other.localVideoEnabled == localVideoEnabled)&&(identical(other.remoteVideoVisible, remoteVideoVisible) || other.remoteVideoVisible == remoteVideoVisible)&&(identical(other.incomingOffer, incomingOffer) || other.incomingOffer == incomingOffer)&&(identical(other.comingCallAnswer, comingCallAnswer) || other.comingCallAnswer == comingCallAnswer)&&(identical(other.audioOnlyCall, audioOnlyCall) || other.audioOnlyCall == audioOnlyCall)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenState,const DeepCollectionEquality().hash(_onlineUsers),myId,remotePeerId,selectedUserForCall,lastReceivedControlSignal,localVideoEnabled,remoteVideoVisible,incomingOffer,comingCallAnswer,audioOnlyCall,errorMessage);

@override
String toString() {
  return 'WebrtcPageState(screenState: $screenState, onlineUsers: $onlineUsers, myId: $myId, remotePeerId: $remotePeerId, selectedUserForCall: $selectedUserForCall, lastReceivedControlSignal: $lastReceivedControlSignal, localVideoEnabled: $localVideoEnabled, remoteVideoVisible: $remoteVideoVisible, incomingOffer: $incomingOffer, comingCallAnswer: $comingCallAnswer, audioOnlyCall: $audioOnlyCall, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$WebrtcPageStateCopyWith<$Res> implements $WebrtcPageStateCopyWith<$Res> {
  factory _$WebrtcPageStateCopyWith(_WebrtcPageState value, $Res Function(_WebrtcPageState) _then) = __$WebrtcPageStateCopyWithImpl;
@override @useResult
$Res call({
 AppScreenState screenState, List<PeerUserModel> onlineUsers, String? myId, String? remotePeerId, PeerUserModel? selectedUserForCall, ControlSignalModel? lastReceivedControlSignal, bool localVideoEnabled, bool remoteVideoVisible, CallOfferModel? incomingOffer, CallAnswerModel? comingCallAnswer, bool audioOnlyCall, String? errorMessage
});


@override $PeerUserModelCopyWith<$Res>? get selectedUserForCall;@override $ControlSignalModelCopyWith<$Res>? get lastReceivedControlSignal;@override $CallOfferModelCopyWith<$Res>? get incomingOffer;@override $CallAnswerModelCopyWith<$Res>? get comingCallAnswer;

}
/// @nodoc
class __$WebrtcPageStateCopyWithImpl<$Res>
    implements _$WebrtcPageStateCopyWith<$Res> {
  __$WebrtcPageStateCopyWithImpl(this._self, this._then);

  final _WebrtcPageState _self;
  final $Res Function(_WebrtcPageState) _then;

/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? screenState = null,Object? onlineUsers = null,Object? myId = freezed,Object? remotePeerId = freezed,Object? selectedUserForCall = freezed,Object? lastReceivedControlSignal = freezed,Object? localVideoEnabled = null,Object? remoteVideoVisible = null,Object? incomingOffer = freezed,Object? comingCallAnswer = freezed,Object? audioOnlyCall = null,Object? errorMessage = freezed,}) {
  return _then(_WebrtcPageState(
screenState: null == screenState ? _self.screenState : screenState // ignore: cast_nullable_to_non_nullable
as AppScreenState,onlineUsers: null == onlineUsers ? _self._onlineUsers : onlineUsers // ignore: cast_nullable_to_non_nullable
as List<PeerUserModel>,myId: freezed == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String?,remotePeerId: freezed == remotePeerId ? _self.remotePeerId : remotePeerId // ignore: cast_nullable_to_non_nullable
as String?,selectedUserForCall: freezed == selectedUserForCall ? _self.selectedUserForCall : selectedUserForCall // ignore: cast_nullable_to_non_nullable
as PeerUserModel?,lastReceivedControlSignal: freezed == lastReceivedControlSignal ? _self.lastReceivedControlSignal : lastReceivedControlSignal // ignore: cast_nullable_to_non_nullable
as ControlSignalModel?,localVideoEnabled: null == localVideoEnabled ? _self.localVideoEnabled : localVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,remoteVideoVisible: null == remoteVideoVisible ? _self.remoteVideoVisible : remoteVideoVisible // ignore: cast_nullable_to_non_nullable
as bool,incomingOffer: freezed == incomingOffer ? _self.incomingOffer : incomingOffer // ignore: cast_nullable_to_non_nullable
as CallOfferModel?,comingCallAnswer: freezed == comingCallAnswer ? _self.comingCallAnswer : comingCallAnswer // ignore: cast_nullable_to_non_nullable
as CallAnswerModel?,audioOnlyCall: null == audioOnlyCall ? _self.audioOnlyCall : audioOnlyCall // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeerUserModelCopyWith<$Res>? get selectedUserForCall {
    if (_self.selectedUserForCall == null) {
    return null;
  }

  return $PeerUserModelCopyWith<$Res>(_self.selectedUserForCall!, (value) {
    return _then(_self.copyWith(selectedUserForCall: value));
  });
}/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ControlSignalModelCopyWith<$Res>? get lastReceivedControlSignal {
    if (_self.lastReceivedControlSignal == null) {
    return null;
  }

  return $ControlSignalModelCopyWith<$Res>(_self.lastReceivedControlSignal!, (value) {
    return _then(_self.copyWith(lastReceivedControlSignal: value));
  });
}/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallOfferModelCopyWith<$Res>? get incomingOffer {
    if (_self.incomingOffer == null) {
    return null;
  }

  return $CallOfferModelCopyWith<$Res>(_self.incomingOffer!, (value) {
    return _then(_self.copyWith(incomingOffer: value));
  });
}/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallAnswerModelCopyWith<$Res>? get comingCallAnswer {
    if (_self.comingCallAnswer == null) {
    return null;
  }

  return $CallAnswerModelCopyWith<$Res>(_self.comingCallAnswer!, (value) {
    return _then(_self.copyWith(comingCallAnswer: value));
  });
}
}

// dart format on

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

 AppScreenState get screenState; String? get myId; List<String> get onlineUsers; String? get remotePeerId;// 현재 통화 중인 상대방 ID
 String? get incomingCallerId;// 전화를 건 사람의 ID
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebrtcPageState&&(identical(other.screenState, screenState) || other.screenState == screenState)&&(identical(other.myId, myId) || other.myId == myId)&&const DeepCollectionEquality().equals(other.onlineUsers, onlineUsers)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.incomingCallerId, incomingCallerId) || other.incomingCallerId == incomingCallerId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenState,myId,const DeepCollectionEquality().hash(onlineUsers),remotePeerId,incomingCallerId,errorMessage);

@override
String toString() {
  return 'WebrtcPageState(screenState: $screenState, myId: $myId, onlineUsers: $onlineUsers, remotePeerId: $remotePeerId, incomingCallerId: $incomingCallerId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $WebrtcPageStateCopyWith<$Res>  {
  factory $WebrtcPageStateCopyWith(WebrtcPageState value, $Res Function(WebrtcPageState) _then) = _$WebrtcPageStateCopyWithImpl;
@useResult
$Res call({
 AppScreenState screenState, String? myId, List<String> onlineUsers, String? remotePeerId, String? incomingCallerId, String? errorMessage
});




}
/// @nodoc
class _$WebrtcPageStateCopyWithImpl<$Res>
    implements $WebrtcPageStateCopyWith<$Res> {
  _$WebrtcPageStateCopyWithImpl(this._self, this._then);

  final WebrtcPageState _self;
  final $Res Function(WebrtcPageState) _then;

/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? screenState = null,Object? myId = freezed,Object? onlineUsers = null,Object? remotePeerId = freezed,Object? incomingCallerId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
screenState: null == screenState ? _self.screenState : screenState // ignore: cast_nullable_to_non_nullable
as AppScreenState,myId: freezed == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String?,onlineUsers: null == onlineUsers ? _self.onlineUsers : onlineUsers // ignore: cast_nullable_to_non_nullable
as List<String>,remotePeerId: freezed == remotePeerId ? _self.remotePeerId : remotePeerId // ignore: cast_nullable_to_non_nullable
as String?,incomingCallerId: freezed == incomingCallerId ? _self.incomingCallerId : incomingCallerId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WebrtcPageState implements WebrtcPageState {
  const _WebrtcPageState({this.screenState = AppScreenState.initial, this.myId, final  List<String> onlineUsers = const [], this.remotePeerId, this.incomingCallerId, this.errorMessage}): _onlineUsers = onlineUsers;
  factory _WebrtcPageState.fromJson(Map<String, dynamic> json) => _$WebrtcPageStateFromJson(json);

@override@JsonKey() final  AppScreenState screenState;
@override final  String? myId;
 final  List<String> _onlineUsers;
@override@JsonKey() List<String> get onlineUsers {
  if (_onlineUsers is EqualUnmodifiableListView) return _onlineUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_onlineUsers);
}

@override final  String? remotePeerId;
// 현재 통화 중인 상대방 ID
@override final  String? incomingCallerId;
// 전화를 건 사람의 ID
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebrtcPageState&&(identical(other.screenState, screenState) || other.screenState == screenState)&&(identical(other.myId, myId) || other.myId == myId)&&const DeepCollectionEquality().equals(other._onlineUsers, _onlineUsers)&&(identical(other.remotePeerId, remotePeerId) || other.remotePeerId == remotePeerId)&&(identical(other.incomingCallerId, incomingCallerId) || other.incomingCallerId == incomingCallerId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,screenState,myId,const DeepCollectionEquality().hash(_onlineUsers),remotePeerId,incomingCallerId,errorMessage);

@override
String toString() {
  return 'WebrtcPageState(screenState: $screenState, myId: $myId, onlineUsers: $onlineUsers, remotePeerId: $remotePeerId, incomingCallerId: $incomingCallerId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$WebrtcPageStateCopyWith<$Res> implements $WebrtcPageStateCopyWith<$Res> {
  factory _$WebrtcPageStateCopyWith(_WebrtcPageState value, $Res Function(_WebrtcPageState) _then) = __$WebrtcPageStateCopyWithImpl;
@override @useResult
$Res call({
 AppScreenState screenState, String? myId, List<String> onlineUsers, String? remotePeerId, String? incomingCallerId, String? errorMessage
});




}
/// @nodoc
class __$WebrtcPageStateCopyWithImpl<$Res>
    implements _$WebrtcPageStateCopyWith<$Res> {
  __$WebrtcPageStateCopyWithImpl(this._self, this._then);

  final _WebrtcPageState _self;
  final $Res Function(_WebrtcPageState) _then;

/// Create a copy of WebrtcPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? screenState = null,Object? myId = freezed,Object? onlineUsers = null,Object? remotePeerId = freezed,Object? incomingCallerId = freezed,Object? errorMessage = freezed,}) {
  return _then(_WebrtcPageState(
screenState: null == screenState ? _self.screenState : screenState // ignore: cast_nullable_to_non_nullable
as AppScreenState,myId: freezed == myId ? _self.myId : myId // ignore: cast_nullable_to_non_nullable
as String?,onlineUsers: null == onlineUsers ? _self._onlineUsers : onlineUsers // ignore: cast_nullable_to_non_nullable
as List<String>,remotePeerId: freezed == remotePeerId ? _self.remotePeerId : remotePeerId // ignore: cast_nullable_to_non_nullable
as String?,incomingCallerId: freezed == incomingCallerId ? _self.incomingCallerId : incomingCallerId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_bar_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NavigationBarPageState {

 bool get isLoading; int get badgeCount; Map<String, int> get chatRoomBadge;
/// Create a copy of NavigationBarPageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationBarPageStateCopyWith<NavigationBarPageState> get copyWith => _$NavigationBarPageStateCopyWithImpl<NavigationBarPageState>(this as NavigationBarPageState, _$identity);

  /// Serializes this NavigationBarPageState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationBarPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.badgeCount, badgeCount) || other.badgeCount == badgeCount)&&const DeepCollectionEquality().equals(other.chatRoomBadge, chatRoomBadge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,badgeCount,const DeepCollectionEquality().hash(chatRoomBadge));

@override
String toString() {
  return 'NavigationBarPageState(isLoading: $isLoading, badgeCount: $badgeCount, chatRoomBadge: $chatRoomBadge)';
}


}

/// @nodoc
abstract mixin class $NavigationBarPageStateCopyWith<$Res>  {
  factory $NavigationBarPageStateCopyWith(NavigationBarPageState value, $Res Function(NavigationBarPageState) _then) = _$NavigationBarPageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, int badgeCount, Map<String, int> chatRoomBadge
});




}
/// @nodoc
class _$NavigationBarPageStateCopyWithImpl<$Res>
    implements $NavigationBarPageStateCopyWith<$Res> {
  _$NavigationBarPageStateCopyWithImpl(this._self, this._then);

  final NavigationBarPageState _self;
  final $Res Function(NavigationBarPageState) _then;

/// Create a copy of NavigationBarPageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? badgeCount = null,Object? chatRoomBadge = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,badgeCount: null == badgeCount ? _self.badgeCount : badgeCount // ignore: cast_nullable_to_non_nullable
as int,chatRoomBadge: null == chatRoomBadge ? _self.chatRoomBadge : chatRoomBadge // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NavigationBarPageState implements NavigationBarPageState {
  const _NavigationBarPageState({this.isLoading = false, this.badgeCount = 0, final  Map<String, int> chatRoomBadge = const {}}): _chatRoomBadge = chatRoomBadge;
  factory _NavigationBarPageState.fromJson(Map<String, dynamic> json) => _$NavigationBarPageStateFromJson(json);

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  int badgeCount;
 final  Map<String, int> _chatRoomBadge;
@override@JsonKey() Map<String, int> get chatRoomBadge {
  if (_chatRoomBadge is EqualUnmodifiableMapView) return _chatRoomBadge;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_chatRoomBadge);
}


/// Create a copy of NavigationBarPageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationBarPageStateCopyWith<_NavigationBarPageState> get copyWith => __$NavigationBarPageStateCopyWithImpl<_NavigationBarPageState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NavigationBarPageStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationBarPageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.badgeCount, badgeCount) || other.badgeCount == badgeCount)&&const DeepCollectionEquality().equals(other._chatRoomBadge, _chatRoomBadge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,badgeCount,const DeepCollectionEquality().hash(_chatRoomBadge));

@override
String toString() {
  return 'NavigationBarPageState(isLoading: $isLoading, badgeCount: $badgeCount, chatRoomBadge: $chatRoomBadge)';
}


}

/// @nodoc
abstract mixin class _$NavigationBarPageStateCopyWith<$Res> implements $NavigationBarPageStateCopyWith<$Res> {
  factory _$NavigationBarPageStateCopyWith(_NavigationBarPageState value, $Res Function(_NavigationBarPageState) _then) = __$NavigationBarPageStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, int badgeCount, Map<String, int> chatRoomBadge
});




}
/// @nodoc
class __$NavigationBarPageStateCopyWithImpl<$Res>
    implements _$NavigationBarPageStateCopyWith<$Res> {
  __$NavigationBarPageStateCopyWithImpl(this._self, this._then);

  final _NavigationBarPageState _self;
  final $Res Function(_NavigationBarPageState) _then;

/// Create a copy of NavigationBarPageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? badgeCount = null,Object? chatRoomBadge = null,}) {
  return _then(_NavigationBarPageState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,badgeCount: null == badgeCount ? _self.badgeCount : badgeCount // ignore: cast_nullable_to_non_nullable
as int,chatRoomBadge: null == chatRoomBadge ? _self._chatRoomBadge : chatRoomBadge // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on

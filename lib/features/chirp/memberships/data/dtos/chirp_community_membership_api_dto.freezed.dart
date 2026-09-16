// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chirp_community_membership_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChirpCommunityMembershipApiDto {

 int get id;@JsonKey(name: 'community_id') int get communityID;@JsonKey(name: 'user_id') String get userID; String get role; bool get banned;@JsonKey(name: 'banned_by_id') String? get bannedByID;@JsonKey(name: 'banning_reason') String? get bannedReason;@JsonKey(name: 'banned_at') DateTime? get bannedAt;@JsonKey(name: 'joined_at') DateTime get joinedAt;
/// Create a copy of ChirpCommunityMembershipApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChirpCommunityMembershipApiDtoCopyWith<ChirpCommunityMembershipApiDto> get copyWith => _$ChirpCommunityMembershipApiDtoCopyWithImpl<ChirpCommunityMembershipApiDto>(this as ChirpCommunityMembershipApiDto, _$identity);

  /// Serializes this ChirpCommunityMembershipApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChirpCommunityMembershipApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.communityID, communityID) || other.communityID == communityID)&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.role, role) || other.role == role)&&(identical(other.banned, banned) || other.banned == banned)&&(identical(other.bannedByID, bannedByID) || other.bannedByID == bannedByID)&&(identical(other.bannedReason, bannedReason) || other.bannedReason == bannedReason)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityID,userID,role,banned,bannedByID,bannedReason,bannedAt,joinedAt);

@override
String toString() {
  return 'ChirpCommunityMembershipApiDto(id: $id, communityID: $communityID, userID: $userID, role: $role, banned: $banned, bannedByID: $bannedByID, bannedReason: $bannedReason, bannedAt: $bannedAt, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $ChirpCommunityMembershipApiDtoCopyWith<$Res>  {
  factory $ChirpCommunityMembershipApiDtoCopyWith(ChirpCommunityMembershipApiDto value, $Res Function(ChirpCommunityMembershipApiDto) _then) = _$ChirpCommunityMembershipApiDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'community_id') int communityID,@JsonKey(name: 'user_id') String userID, String role, bool banned,@JsonKey(name: 'banned_by_id') String? bannedByID,@JsonKey(name: 'banning_reason') String? bannedReason,@JsonKey(name: 'banned_at') DateTime? bannedAt,@JsonKey(name: 'joined_at') DateTime joinedAt
});




}
/// @nodoc
class _$ChirpCommunityMembershipApiDtoCopyWithImpl<$Res>
    implements $ChirpCommunityMembershipApiDtoCopyWith<$Res> {
  _$ChirpCommunityMembershipApiDtoCopyWithImpl(this._self, this._then);

  final ChirpCommunityMembershipApiDto _self;
  final $Res Function(ChirpCommunityMembershipApiDto) _then;

/// Create a copy of ChirpCommunityMembershipApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? communityID = null,Object? userID = null,Object? role = null,Object? banned = null,Object? bannedByID = freezed,Object? bannedReason = freezed,Object? bannedAt = freezed,Object? joinedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityID: null == communityID ? _self.communityID : communityID // ignore: cast_nullable_to_non_nullable
as int,userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,banned: null == banned ? _self.banned : banned // ignore: cast_nullable_to_non_nullable
as bool,bannedByID: freezed == bannedByID ? _self.bannedByID : bannedByID // ignore: cast_nullable_to_non_nullable
as String?,bannedReason: freezed == bannedReason ? _self.bannedReason : bannedReason // ignore: cast_nullable_to_non_nullable
as String?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChirpCommunityMembershipApiDto].
extension ChirpCommunityMembershipApiDtoPatterns on ChirpCommunityMembershipApiDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChirpCommunityMembershipApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChirpCommunityMembershipApiDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChirpCommunityMembershipApiDto value)  $default,){
final _that = this;
switch (_that) {
case _ChirpCommunityMembershipApiDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChirpCommunityMembershipApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChirpCommunityMembershipApiDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'community_id')  int communityID, @JsonKey(name: 'user_id')  String userID,  String role,  bool banned, @JsonKey(name: 'banned_by_id')  String? bannedByID, @JsonKey(name: 'banning_reason')  String? bannedReason, @JsonKey(name: 'banned_at')  DateTime? bannedAt, @JsonKey(name: 'joined_at')  DateTime joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChirpCommunityMembershipApiDto() when $default != null:
return $default(_that.id,_that.communityID,_that.userID,_that.role,_that.banned,_that.bannedByID,_that.bannedReason,_that.bannedAt,_that.joinedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'community_id')  int communityID, @JsonKey(name: 'user_id')  String userID,  String role,  bool banned, @JsonKey(name: 'banned_by_id')  String? bannedByID, @JsonKey(name: 'banning_reason')  String? bannedReason, @JsonKey(name: 'banned_at')  DateTime? bannedAt, @JsonKey(name: 'joined_at')  DateTime joinedAt)  $default,) {final _that = this;
switch (_that) {
case _ChirpCommunityMembershipApiDto():
return $default(_that.id,_that.communityID,_that.userID,_that.role,_that.banned,_that.bannedByID,_that.bannedReason,_that.bannedAt,_that.joinedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'community_id')  int communityID, @JsonKey(name: 'user_id')  String userID,  String role,  bool banned, @JsonKey(name: 'banned_by_id')  String? bannedByID, @JsonKey(name: 'banning_reason')  String? bannedReason, @JsonKey(name: 'banned_at')  DateTime? bannedAt, @JsonKey(name: 'joined_at')  DateTime joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChirpCommunityMembershipApiDto() when $default != null:
return $default(_that.id,_that.communityID,_that.userID,_that.role,_that.banned,_that.bannedByID,_that.bannedReason,_that.bannedAt,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChirpCommunityMembershipApiDto implements ChirpCommunityMembershipApiDto {
  const _ChirpCommunityMembershipApiDto({required this.id, @JsonKey(name: 'community_id') required this.communityID, @JsonKey(name: 'user_id') required this.userID, required this.role, this.banned = false, @JsonKey(name: 'banned_by_id') this.bannedByID, @JsonKey(name: 'banning_reason') this.bannedReason, @JsonKey(name: 'banned_at') this.bannedAt, @JsonKey(name: 'joined_at') required this.joinedAt});
  factory _ChirpCommunityMembershipApiDto.fromJson(Map<String, dynamic> json) => _$ChirpCommunityMembershipApiDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'community_id') final  int communityID;
@override@JsonKey(name: 'user_id') final  String userID;
@override final  String role;
@override@JsonKey() final  bool banned;
@override@JsonKey(name: 'banned_by_id') final  String? bannedByID;
@override@JsonKey(name: 'banning_reason') final  String? bannedReason;
@override@JsonKey(name: 'banned_at') final  DateTime? bannedAt;
@override@JsonKey(name: 'joined_at') final  DateTime joinedAt;

/// Create a copy of ChirpCommunityMembershipApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChirpCommunityMembershipApiDtoCopyWith<_ChirpCommunityMembershipApiDto> get copyWith => __$ChirpCommunityMembershipApiDtoCopyWithImpl<_ChirpCommunityMembershipApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChirpCommunityMembershipApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChirpCommunityMembershipApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.communityID, communityID) || other.communityID == communityID)&&(identical(other.userID, userID) || other.userID == userID)&&(identical(other.role, role) || other.role == role)&&(identical(other.banned, banned) || other.banned == banned)&&(identical(other.bannedByID, bannedByID) || other.bannedByID == bannedByID)&&(identical(other.bannedReason, bannedReason) || other.bannedReason == bannedReason)&&(identical(other.bannedAt, bannedAt) || other.bannedAt == bannedAt)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,communityID,userID,role,banned,bannedByID,bannedReason,bannedAt,joinedAt);

@override
String toString() {
  return 'ChirpCommunityMembershipApiDto(id: $id, communityID: $communityID, userID: $userID, role: $role, banned: $banned, bannedByID: $bannedByID, bannedReason: $bannedReason, bannedAt: $bannedAt, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$ChirpCommunityMembershipApiDtoCopyWith<$Res> implements $ChirpCommunityMembershipApiDtoCopyWith<$Res> {
  factory _$ChirpCommunityMembershipApiDtoCopyWith(_ChirpCommunityMembershipApiDto value, $Res Function(_ChirpCommunityMembershipApiDto) _then) = __$ChirpCommunityMembershipApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'community_id') int communityID,@JsonKey(name: 'user_id') String userID, String role, bool banned,@JsonKey(name: 'banned_by_id') String? bannedByID,@JsonKey(name: 'banning_reason') String? bannedReason,@JsonKey(name: 'banned_at') DateTime? bannedAt,@JsonKey(name: 'joined_at') DateTime joinedAt
});




}
/// @nodoc
class __$ChirpCommunityMembershipApiDtoCopyWithImpl<$Res>
    implements _$ChirpCommunityMembershipApiDtoCopyWith<$Res> {
  __$ChirpCommunityMembershipApiDtoCopyWithImpl(this._self, this._then);

  final _ChirpCommunityMembershipApiDto _self;
  final $Res Function(_ChirpCommunityMembershipApiDto) _then;

/// Create a copy of ChirpCommunityMembershipApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? communityID = null,Object? userID = null,Object? role = null,Object? banned = null,Object? bannedByID = freezed,Object? bannedReason = freezed,Object? bannedAt = freezed,Object? joinedAt = null,}) {
  return _then(_ChirpCommunityMembershipApiDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,communityID: null == communityID ? _self.communityID : communityID // ignore: cast_nullable_to_non_nullable
as int,userID: null == userID ? _self.userID : userID // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,banned: null == banned ? _self.banned : banned // ignore: cast_nullable_to_non_nullable
as bool,bannedByID: freezed == bannedByID ? _self.bannedByID : bannedByID // ignore: cast_nullable_to_non_nullable
as String?,bannedReason: freezed == bannedReason ? _self.bannedReason : bannedReason // ignore: cast_nullable_to_non_nullable
as String?,bannedAt: freezed == bannedAt ? _self.bannedAt : bannedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

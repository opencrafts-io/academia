// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommunityApiDto {

 int get id; String get name; String? get description; bool get nsfw; bool get private; bool get verified; String get visibility;@JsonKey(name: 'member_count') int get memberCount;@JsonKey(name: 'moderator_count') int get moderatorCount;@JsonKey(name: 'banned_users_count') int get bannedUsersCount;@JsonKey(name: 'monthly_visitor_count') int get monthlyVisitorCount;@JsonKey(name: 'weekly_visitor_count') int get weeklyVisitorCount; String? get banner;@JsonKey(name: 'banner_height') int get bannerHeight;@JsonKey(name: 'banner_width') int get bannerWidth;@JsonKey(name: 'banner_url') String? get bannerUrl;@JsonKey(name: 'profile_picture') String? get profilePicture;@JsonKey(name: 'profile_picture_height') int get profilePictureHeight;@JsonKey(name: 'profile_picture_width') int get profilePictureWidth;@JsonKey(name: 'profile_picture_url') String? get profilePictureUrl;@JsonKey(name: 'creator_id') String get creatorId; List<String> get guidelines;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime get updatedAt;
/// Create a copy of CommunityApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityApiDtoCopyWith<CommunityApiDto> get copyWith => _$CommunityApiDtoCopyWithImpl<CommunityApiDto>(this as CommunityApiDto, _$identity);

  /// Serializes this CommunityApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.private, private) || other.private == private)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.moderatorCount, moderatorCount) || other.moderatorCount == moderatorCount)&&(identical(other.bannedUsersCount, bannedUsersCount) || other.bannedUsersCount == bannedUsersCount)&&(identical(other.monthlyVisitorCount, monthlyVisitorCount) || other.monthlyVisitorCount == monthlyVisitorCount)&&(identical(other.weeklyVisitorCount, weeklyVisitorCount) || other.weeklyVisitorCount == weeklyVisitorCount)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.bannerHeight, bannerHeight) || other.bannerHeight == bannerHeight)&&(identical(other.bannerWidth, bannerWidth) || other.bannerWidth == bannerWidth)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.profilePictureHeight, profilePictureHeight) || other.profilePictureHeight == profilePictureHeight)&&(identical(other.profilePictureWidth, profilePictureWidth) || other.profilePictureWidth == profilePictureWidth)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&const DeepCollectionEquality().equals(other.guidelines, guidelines)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,nsfw,private,verified,visibility,memberCount,moderatorCount,bannedUsersCount,monthlyVisitorCount,weeklyVisitorCount,banner,bannerHeight,bannerWidth,bannerUrl,profilePicture,profilePictureHeight,profilePictureWidth,profilePictureUrl,creatorId,const DeepCollectionEquality().hash(guidelines),createdAt,updatedAt]);

@override
String toString() {
  return 'CommunityApiDto(id: $id, name: $name, description: $description, nsfw: $nsfw, private: $private, verified: $verified, visibility: $visibility, memberCount: $memberCount, moderatorCount: $moderatorCount, bannedUsersCount: $bannedUsersCount, monthlyVisitorCount: $monthlyVisitorCount, weeklyVisitorCount: $weeklyVisitorCount, banner: $banner, bannerHeight: $bannerHeight, bannerWidth: $bannerWidth, bannerUrl: $bannerUrl, profilePicture: $profilePicture, profilePictureHeight: $profilePictureHeight, profilePictureWidth: $profilePictureWidth, profilePictureUrl: $profilePictureUrl, creatorId: $creatorId, guidelines: $guidelines, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CommunityApiDtoCopyWith<$Res>  {
  factory $CommunityApiDtoCopyWith(CommunityApiDto value, $Res Function(CommunityApiDto) _then) = _$CommunityApiDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, bool nsfw, bool private, bool verified, String visibility,@JsonKey(name: 'member_count') int memberCount,@JsonKey(name: 'moderator_count') int moderatorCount,@JsonKey(name: 'banned_users_count') int bannedUsersCount,@JsonKey(name: 'monthly_visitor_count') int monthlyVisitorCount,@JsonKey(name: 'weekly_visitor_count') int weeklyVisitorCount, String? banner,@JsonKey(name: 'banner_height') int bannerHeight,@JsonKey(name: 'banner_width') int bannerWidth,@JsonKey(name: 'banner_url') String? bannerUrl,@JsonKey(name: 'profile_picture') String? profilePicture,@JsonKey(name: 'profile_picture_height') int profilePictureHeight,@JsonKey(name: 'profile_picture_width') int profilePictureWidth,@JsonKey(name: 'profile_picture_url') String? profilePictureUrl,@JsonKey(name: 'creator_id') String creatorId, List<String> guidelines,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class _$CommunityApiDtoCopyWithImpl<$Res>
    implements $CommunityApiDtoCopyWith<$Res> {
  _$CommunityApiDtoCopyWithImpl(this._self, this._then);

  final CommunityApiDto _self;
  final $Res Function(CommunityApiDto) _then;

/// Create a copy of CommunityApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? nsfw = null,Object? private = null,Object? verified = null,Object? visibility = null,Object? memberCount = null,Object? moderatorCount = null,Object? bannedUsersCount = null,Object? monthlyVisitorCount = null,Object? weeklyVisitorCount = null,Object? banner = freezed,Object? bannerHeight = null,Object? bannerWidth = null,Object? bannerUrl = freezed,Object? profilePicture = freezed,Object? profilePictureHeight = null,Object? profilePictureWidth = null,Object? profilePictureUrl = freezed,Object? creatorId = null,Object? guidelines = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,nsfw: null == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool,private: null == private ? _self.private : private // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,moderatorCount: null == moderatorCount ? _self.moderatorCount : moderatorCount // ignore: cast_nullable_to_non_nullable
as int,bannedUsersCount: null == bannedUsersCount ? _self.bannedUsersCount : bannedUsersCount // ignore: cast_nullable_to_non_nullable
as int,monthlyVisitorCount: null == monthlyVisitorCount ? _self.monthlyVisitorCount : monthlyVisitorCount // ignore: cast_nullable_to_non_nullable
as int,weeklyVisitorCount: null == weeklyVisitorCount ? _self.weeklyVisitorCount : weeklyVisitorCount // ignore: cast_nullable_to_non_nullable
as int,banner: freezed == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as String?,bannerHeight: null == bannerHeight ? _self.bannerHeight : bannerHeight // ignore: cast_nullable_to_non_nullable
as int,bannerWidth: null == bannerWidth ? _self.bannerWidth : bannerWidth // ignore: cast_nullable_to_non_nullable
as int,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,profilePictureHeight: null == profilePictureHeight ? _self.profilePictureHeight : profilePictureHeight // ignore: cast_nullable_to_non_nullable
as int,profilePictureWidth: null == profilePictureWidth ? _self.profilePictureWidth : profilePictureWidth // ignore: cast_nullable_to_non_nullable
as int,profilePictureUrl: freezed == profilePictureUrl ? _self.profilePictureUrl : profilePictureUrl // ignore: cast_nullable_to_non_nullable
as String?,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,guidelines: null == guidelines ? _self.guidelines : guidelines // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityApiDto].
extension CommunityApiDtoPatterns on CommunityApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityApiDto value)  $default,){
final _that = this;
switch (_that) {
case _CommunityApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  bool nsfw,  bool private,  bool verified,  String visibility, @JsonKey(name: 'member_count')  int memberCount, @JsonKey(name: 'moderator_count')  int moderatorCount, @JsonKey(name: 'banned_users_count')  int bannedUsersCount, @JsonKey(name: 'monthly_visitor_count')  int monthlyVisitorCount, @JsonKey(name: 'weekly_visitor_count')  int weeklyVisitorCount,  String? banner, @JsonKey(name: 'banner_height')  int bannerHeight, @JsonKey(name: 'banner_width')  int bannerWidth, @JsonKey(name: 'banner_url')  String? bannerUrl, @JsonKey(name: 'profile_picture')  String? profilePicture, @JsonKey(name: 'profile_picture_height')  int profilePictureHeight, @JsonKey(name: 'profile_picture_width')  int profilePictureWidth, @JsonKey(name: 'profile_picture_url')  String? profilePictureUrl, @JsonKey(name: 'creator_id')  String creatorId,  List<String> guidelines, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityApiDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.nsfw,_that.private,_that.verified,_that.visibility,_that.memberCount,_that.moderatorCount,_that.bannedUsersCount,_that.monthlyVisitorCount,_that.weeklyVisitorCount,_that.banner,_that.bannerHeight,_that.bannerWidth,_that.bannerUrl,_that.profilePicture,_that.profilePictureHeight,_that.profilePictureWidth,_that.profilePictureUrl,_that.creatorId,_that.guidelines,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  bool nsfw,  bool private,  bool verified,  String visibility, @JsonKey(name: 'member_count')  int memberCount, @JsonKey(name: 'moderator_count')  int moderatorCount, @JsonKey(name: 'banned_users_count')  int bannedUsersCount, @JsonKey(name: 'monthly_visitor_count')  int monthlyVisitorCount, @JsonKey(name: 'weekly_visitor_count')  int weeklyVisitorCount,  String? banner, @JsonKey(name: 'banner_height')  int bannerHeight, @JsonKey(name: 'banner_width')  int bannerWidth, @JsonKey(name: 'banner_url')  String? bannerUrl, @JsonKey(name: 'profile_picture')  String? profilePicture, @JsonKey(name: 'profile_picture_height')  int profilePictureHeight, @JsonKey(name: 'profile_picture_width')  int profilePictureWidth, @JsonKey(name: 'profile_picture_url')  String? profilePictureUrl, @JsonKey(name: 'creator_id')  String creatorId,  List<String> guidelines, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityApiDto():
return $default(_that.id,_that.name,_that.description,_that.nsfw,_that.private,_that.verified,_that.visibility,_that.memberCount,_that.moderatorCount,_that.bannedUsersCount,_that.monthlyVisitorCount,_that.weeklyVisitorCount,_that.banner,_that.bannerHeight,_that.bannerWidth,_that.bannerUrl,_that.profilePicture,_that.profilePictureHeight,_that.profilePictureWidth,_that.profilePictureUrl,_that.creatorId,_that.guidelines,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  bool nsfw,  bool private,  bool verified,  String visibility, @JsonKey(name: 'member_count')  int memberCount, @JsonKey(name: 'moderator_count')  int moderatorCount, @JsonKey(name: 'banned_users_count')  int bannedUsersCount, @JsonKey(name: 'monthly_visitor_count')  int monthlyVisitorCount, @JsonKey(name: 'weekly_visitor_count')  int weeklyVisitorCount,  String? banner, @JsonKey(name: 'banner_height')  int bannerHeight, @JsonKey(name: 'banner_width')  int bannerWidth, @JsonKey(name: 'banner_url')  String? bannerUrl, @JsonKey(name: 'profile_picture')  String? profilePicture, @JsonKey(name: 'profile_picture_height')  int profilePictureHeight, @JsonKey(name: 'profile_picture_width')  int profilePictureWidth, @JsonKey(name: 'profile_picture_url')  String? profilePictureUrl, @JsonKey(name: 'creator_id')  String creatorId,  List<String> guidelines, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityApiDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.nsfw,_that.private,_that.verified,_that.visibility,_that.memberCount,_that.moderatorCount,_that.bannedUsersCount,_that.monthlyVisitorCount,_that.weeklyVisitorCount,_that.banner,_that.bannerHeight,_that.bannerWidth,_that.bannerUrl,_that.profilePicture,_that.profilePictureHeight,_that.profilePictureWidth,_that.profilePictureUrl,_that.creatorId,_that.guidelines,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityApiDto implements CommunityApiDto {
  const _CommunityApiDto({required this.id, required this.name, this.description, this.nsfw = false, this.private = false, this.verified = false, required this.visibility, @JsonKey(name: 'member_count') this.memberCount = 0, @JsonKey(name: 'moderator_count') this.moderatorCount = 0, @JsonKey(name: 'banned_users_count') this.bannedUsersCount = 0, @JsonKey(name: 'monthly_visitor_count') this.monthlyVisitorCount = 0, @JsonKey(name: 'weekly_visitor_count') this.weeklyVisitorCount = 0, this.banner, @JsonKey(name: 'banner_height') this.bannerHeight = 0, @JsonKey(name: 'banner_width') this.bannerWidth = 0, @JsonKey(name: 'banner_url') this.bannerUrl, @JsonKey(name: 'profile_picture') this.profilePicture, @JsonKey(name: 'profile_picture_height') this.profilePictureHeight = 0, @JsonKey(name: 'profile_picture_width') this.profilePictureWidth = 0, @JsonKey(name: 'profile_picture_url') this.profilePictureUrl, @JsonKey(name: 'creator_id') required this.creatorId, final  List<String> guidelines = const [], @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt}): _guidelines = guidelines;
  factory _CommunityApiDto.fromJson(Map<String, dynamic> json) => _$CommunityApiDtoFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override@JsonKey() final  bool nsfw;
@override@JsonKey() final  bool private;
@override@JsonKey() final  bool verified;
@override final  String visibility;
@override@JsonKey(name: 'member_count') final  int memberCount;
@override@JsonKey(name: 'moderator_count') final  int moderatorCount;
@override@JsonKey(name: 'banned_users_count') final  int bannedUsersCount;
@override@JsonKey(name: 'monthly_visitor_count') final  int monthlyVisitorCount;
@override@JsonKey(name: 'weekly_visitor_count') final  int weeklyVisitorCount;
@override final  String? banner;
@override@JsonKey(name: 'banner_height') final  int bannerHeight;
@override@JsonKey(name: 'banner_width') final  int bannerWidth;
@override@JsonKey(name: 'banner_url') final  String? bannerUrl;
@override@JsonKey(name: 'profile_picture') final  String? profilePicture;
@override@JsonKey(name: 'profile_picture_height') final  int profilePictureHeight;
@override@JsonKey(name: 'profile_picture_width') final  int profilePictureWidth;
@override@JsonKey(name: 'profile_picture_url') final  String? profilePictureUrl;
@override@JsonKey(name: 'creator_id') final  String creatorId;
 final  List<String> _guidelines;
@override@JsonKey() List<String> get guidelines {
  if (_guidelines is EqualUnmodifiableListView) return _guidelines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_guidelines);
}

@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime updatedAt;

/// Create a copy of CommunityApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityApiDtoCopyWith<_CommunityApiDto> get copyWith => __$CommunityApiDtoCopyWithImpl<_CommunityApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.private, private) || other.private == private)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.moderatorCount, moderatorCount) || other.moderatorCount == moderatorCount)&&(identical(other.bannedUsersCount, bannedUsersCount) || other.bannedUsersCount == bannedUsersCount)&&(identical(other.monthlyVisitorCount, monthlyVisitorCount) || other.monthlyVisitorCount == monthlyVisitorCount)&&(identical(other.weeklyVisitorCount, weeklyVisitorCount) || other.weeklyVisitorCount == weeklyVisitorCount)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.bannerHeight, bannerHeight) || other.bannerHeight == bannerHeight)&&(identical(other.bannerWidth, bannerWidth) || other.bannerWidth == bannerWidth)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.profilePictureHeight, profilePictureHeight) || other.profilePictureHeight == profilePictureHeight)&&(identical(other.profilePictureWidth, profilePictureWidth) || other.profilePictureWidth == profilePictureWidth)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&const DeepCollectionEquality().equals(other._guidelines, _guidelines)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,nsfw,private,verified,visibility,memberCount,moderatorCount,bannedUsersCount,monthlyVisitorCount,weeklyVisitorCount,banner,bannerHeight,bannerWidth,bannerUrl,profilePicture,profilePictureHeight,profilePictureWidth,profilePictureUrl,creatorId,const DeepCollectionEquality().hash(_guidelines),createdAt,updatedAt]);

@override
String toString() {
  return 'CommunityApiDto(id: $id, name: $name, description: $description, nsfw: $nsfw, private: $private, verified: $verified, visibility: $visibility, memberCount: $memberCount, moderatorCount: $moderatorCount, bannedUsersCount: $bannedUsersCount, monthlyVisitorCount: $monthlyVisitorCount, weeklyVisitorCount: $weeklyVisitorCount, banner: $banner, bannerHeight: $bannerHeight, bannerWidth: $bannerWidth, bannerUrl: $bannerUrl, profilePicture: $profilePicture, profilePictureHeight: $profilePictureHeight, profilePictureWidth: $profilePictureWidth, profilePictureUrl: $profilePictureUrl, creatorId: $creatorId, guidelines: $guidelines, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityApiDtoCopyWith<$Res> implements $CommunityApiDtoCopyWith<$Res> {
  factory _$CommunityApiDtoCopyWith(_CommunityApiDto value, $Res Function(_CommunityApiDto) _then) = __$CommunityApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, bool nsfw, bool private, bool verified, String visibility,@JsonKey(name: 'member_count') int memberCount,@JsonKey(name: 'moderator_count') int moderatorCount,@JsonKey(name: 'banned_users_count') int bannedUsersCount,@JsonKey(name: 'monthly_visitor_count') int monthlyVisitorCount,@JsonKey(name: 'weekly_visitor_count') int weeklyVisitorCount, String? banner,@JsonKey(name: 'banner_height') int bannerHeight,@JsonKey(name: 'banner_width') int bannerWidth,@JsonKey(name: 'banner_url') String? bannerUrl,@JsonKey(name: 'profile_picture') String? profilePicture,@JsonKey(name: 'profile_picture_height') int profilePictureHeight,@JsonKey(name: 'profile_picture_width') int profilePictureWidth,@JsonKey(name: 'profile_picture_url') String? profilePictureUrl,@JsonKey(name: 'creator_id') String creatorId, List<String> guidelines,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime updatedAt
});




}
/// @nodoc
class __$CommunityApiDtoCopyWithImpl<$Res>
    implements _$CommunityApiDtoCopyWith<$Res> {
  __$CommunityApiDtoCopyWithImpl(this._self, this._then);

  final _CommunityApiDto _self;
  final $Res Function(_CommunityApiDto) _then;

/// Create a copy of CommunityApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? nsfw = null,Object? private = null,Object? verified = null,Object? visibility = null,Object? memberCount = null,Object? moderatorCount = null,Object? bannedUsersCount = null,Object? monthlyVisitorCount = null,Object? weeklyVisitorCount = null,Object? banner = freezed,Object? bannerHeight = null,Object? bannerWidth = null,Object? bannerUrl = freezed,Object? profilePicture = freezed,Object? profilePictureHeight = null,Object? profilePictureWidth = null,Object? profilePictureUrl = freezed,Object? creatorId = null,Object? guidelines = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CommunityApiDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,nsfw: null == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool,private: null == private ? _self.private : private // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,moderatorCount: null == moderatorCount ? _self.moderatorCount : moderatorCount // ignore: cast_nullable_to_non_nullable
as int,bannedUsersCount: null == bannedUsersCount ? _self.bannedUsersCount : bannedUsersCount // ignore: cast_nullable_to_non_nullable
as int,monthlyVisitorCount: null == monthlyVisitorCount ? _self.monthlyVisitorCount : monthlyVisitorCount // ignore: cast_nullable_to_non_nullable
as int,weeklyVisitorCount: null == weeklyVisitorCount ? _self.weeklyVisitorCount : weeklyVisitorCount // ignore: cast_nullable_to_non_nullable
as int,banner: freezed == banner ? _self.banner : banner // ignore: cast_nullable_to_non_nullable
as String?,bannerHeight: null == bannerHeight ? _self.bannerHeight : bannerHeight // ignore: cast_nullable_to_non_nullable
as int,bannerWidth: null == bannerWidth ? _self.bannerWidth : bannerWidth // ignore: cast_nullable_to_non_nullable
as int,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,profilePictureHeight: null == profilePictureHeight ? _self.profilePictureHeight : profilePictureHeight // ignore: cast_nullable_to_non_nullable
as int,profilePictureWidth: null == profilePictureWidth ? _self.profilePictureWidth : profilePictureWidth // ignore: cast_nullable_to_non_nullable
as int,profilePictureUrl: freezed == profilePictureUrl ? _self.profilePictureUrl : profilePictureUrl // ignore: cast_nullable_to_non_nullable
as String?,creatorId: null == creatorId ? _self.creatorId : creatorId // ignore: cast_nullable_to_non_nullable
as String,guidelines: null == guidelines ? _self._guidelines : guidelines // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

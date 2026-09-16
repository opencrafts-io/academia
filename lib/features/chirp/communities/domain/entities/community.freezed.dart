// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Community {

 int get id; String get name; String? get description; bool get nsfw; bool get private; bool get verified; String get visibility; List<String> get guidelines; int get memberCount; int get moderatorCount; int get bannedUsersCount; int get monthlyVisitorCount; int get weeklyVisitorCount; String? get banner; int get bannerHeight; int get bannerWidth; String? get bannerUrl; String? get profilePicture; int get profilePictureHeight; int get profilePictureWidth; String? get profilePictureUrl; String get creatorId; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityCopyWith<Community> get copyWith => _$CommunityCopyWithImpl<Community>(this as Community, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Community&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.private, private) || other.private == private)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other.guidelines, guidelines)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.moderatorCount, moderatorCount) || other.moderatorCount == moderatorCount)&&(identical(other.bannedUsersCount, bannedUsersCount) || other.bannedUsersCount == bannedUsersCount)&&(identical(other.monthlyVisitorCount, monthlyVisitorCount) || other.monthlyVisitorCount == monthlyVisitorCount)&&(identical(other.weeklyVisitorCount, weeklyVisitorCount) || other.weeklyVisitorCount == weeklyVisitorCount)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.bannerHeight, bannerHeight) || other.bannerHeight == bannerHeight)&&(identical(other.bannerWidth, bannerWidth) || other.bannerWidth == bannerWidth)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.profilePictureHeight, profilePictureHeight) || other.profilePictureHeight == profilePictureHeight)&&(identical(other.profilePictureWidth, profilePictureWidth) || other.profilePictureWidth == profilePictureWidth)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,nsfw,private,verified,visibility,const DeepCollectionEquality().hash(guidelines),memberCount,moderatorCount,bannedUsersCount,monthlyVisitorCount,weeklyVisitorCount,banner,bannerHeight,bannerWidth,bannerUrl,profilePicture,profilePictureHeight,profilePictureWidth,profilePictureUrl,creatorId,createdAt,updatedAt]);

@override
String toString() {
  return 'Community(id: $id, name: $name, description: $description, nsfw: $nsfw, private: $private, verified: $verified, visibility: $visibility, guidelines: $guidelines, memberCount: $memberCount, moderatorCount: $moderatorCount, bannedUsersCount: $bannedUsersCount, monthlyVisitorCount: $monthlyVisitorCount, weeklyVisitorCount: $weeklyVisitorCount, banner: $banner, bannerHeight: $bannerHeight, bannerWidth: $bannerWidth, bannerUrl: $bannerUrl, profilePicture: $profilePicture, profilePictureHeight: $profilePictureHeight, profilePictureWidth: $profilePictureWidth, profilePictureUrl: $profilePictureUrl, creatorId: $creatorId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CommunityCopyWith<$Res>  {
  factory $CommunityCopyWith(Community value, $Res Function(Community) _then) = _$CommunityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, bool nsfw, bool private, bool verified, String visibility, List<String> guidelines, int memberCount, int moderatorCount, int bannedUsersCount, int monthlyVisitorCount, int weeklyVisitorCount, String? banner, int bannerHeight, int bannerWidth, String? bannerUrl, String? profilePicture, int profilePictureHeight, int profilePictureWidth, String? profilePictureUrl, String creatorId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$CommunityCopyWithImpl<$Res>
    implements $CommunityCopyWith<$Res> {
  _$CommunityCopyWithImpl(this._self, this._then);

  final Community _self;
  final $Res Function(Community) _then;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? nsfw = null,Object? private = null,Object? verified = null,Object? visibility = null,Object? guidelines = null,Object? memberCount = null,Object? moderatorCount = null,Object? bannedUsersCount = null,Object? monthlyVisitorCount = null,Object? weeklyVisitorCount = null,Object? banner = freezed,Object? bannerHeight = null,Object? bannerWidth = null,Object? bannerUrl = freezed,Object? profilePicture = freezed,Object? profilePictureHeight = null,Object? profilePictureWidth = null,Object? profilePictureUrl = freezed,Object? creatorId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,nsfw: null == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool,private: null == private ? _self.private : private // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,guidelines: null == guidelines ? _self.guidelines : guidelines // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
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
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Community].
extension CommunityPatterns on Community {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Community value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Community() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Community value)  $default,){
final _that = this;
switch (_that) {
case _Community():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Community value)?  $default,){
final _that = this;
switch (_that) {
case _Community() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  bool nsfw,  bool private,  bool verified,  String visibility,  List<String> guidelines,  int memberCount,  int moderatorCount,  int bannedUsersCount,  int monthlyVisitorCount,  int weeklyVisitorCount,  String? banner,  int bannerHeight,  int bannerWidth,  String? bannerUrl,  String? profilePicture,  int profilePictureHeight,  int profilePictureWidth,  String? profilePictureUrl,  String creatorId,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Community() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.nsfw,_that.private,_that.verified,_that.visibility,_that.guidelines,_that.memberCount,_that.moderatorCount,_that.bannedUsersCount,_that.monthlyVisitorCount,_that.weeklyVisitorCount,_that.banner,_that.bannerHeight,_that.bannerWidth,_that.bannerUrl,_that.profilePicture,_that.profilePictureHeight,_that.profilePictureWidth,_that.profilePictureUrl,_that.creatorId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  bool nsfw,  bool private,  bool verified,  String visibility,  List<String> guidelines,  int memberCount,  int moderatorCount,  int bannedUsersCount,  int monthlyVisitorCount,  int weeklyVisitorCount,  String? banner,  int bannerHeight,  int bannerWidth,  String? bannerUrl,  String? profilePicture,  int profilePictureHeight,  int profilePictureWidth,  String? profilePictureUrl,  String creatorId,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Community():
return $default(_that.id,_that.name,_that.description,_that.nsfw,_that.private,_that.verified,_that.visibility,_that.guidelines,_that.memberCount,_that.moderatorCount,_that.bannedUsersCount,_that.monthlyVisitorCount,_that.weeklyVisitorCount,_that.banner,_that.bannerHeight,_that.bannerWidth,_that.bannerUrl,_that.profilePicture,_that.profilePictureHeight,_that.profilePictureWidth,_that.profilePictureUrl,_that.creatorId,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  bool nsfw,  bool private,  bool verified,  String visibility,  List<String> guidelines,  int memberCount,  int moderatorCount,  int bannedUsersCount,  int monthlyVisitorCount,  int weeklyVisitorCount,  String? banner,  int bannerHeight,  int bannerWidth,  String? bannerUrl,  String? profilePicture,  int profilePictureHeight,  int profilePictureWidth,  String? profilePictureUrl,  String creatorId,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Community() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.nsfw,_that.private,_that.verified,_that.visibility,_that.guidelines,_that.memberCount,_that.moderatorCount,_that.bannedUsersCount,_that.monthlyVisitorCount,_that.weeklyVisitorCount,_that.banner,_that.bannerHeight,_that.bannerWidth,_that.bannerUrl,_that.profilePicture,_that.profilePictureHeight,_that.profilePictureWidth,_that.profilePictureUrl,_that.creatorId,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Community implements Community {
  const _Community({required this.id, required this.name, this.description, this.nsfw = false, this.private = false, this.verified = false, required this.visibility, required final  List<String> guidelines, this.memberCount = 0, this.moderatorCount = 0, this.bannedUsersCount = 0, this.monthlyVisitorCount = 0, this.weeklyVisitorCount = 0, this.banner, this.bannerHeight = 0, this.bannerWidth = 0, this.bannerUrl, this.profilePicture, this.profilePictureHeight = 0, this.profilePictureWidth = 0, this.profilePictureUrl, required this.creatorId, required this.createdAt, required this.updatedAt}): _guidelines = guidelines;
  

@override final  int id;
@override final  String name;
@override final  String? description;
@override@JsonKey() final  bool nsfw;
@override@JsonKey() final  bool private;
@override@JsonKey() final  bool verified;
@override final  String visibility;
 final  List<String> _guidelines;
@override List<String> get guidelines {
  if (_guidelines is EqualUnmodifiableListView) return _guidelines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_guidelines);
}

@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int moderatorCount;
@override@JsonKey() final  int bannedUsersCount;
@override@JsonKey() final  int monthlyVisitorCount;
@override@JsonKey() final  int weeklyVisitorCount;
@override final  String? banner;
@override@JsonKey() final  int bannerHeight;
@override@JsonKey() final  int bannerWidth;
@override final  String? bannerUrl;
@override final  String? profilePicture;
@override@JsonKey() final  int profilePictureHeight;
@override@JsonKey() final  int profilePictureWidth;
@override final  String? profilePictureUrl;
@override final  String creatorId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityCopyWith<_Community> get copyWith => __$CommunityCopyWithImpl<_Community>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Community&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.private, private) || other.private == private)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&const DeepCollectionEquality().equals(other._guidelines, _guidelines)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.moderatorCount, moderatorCount) || other.moderatorCount == moderatorCount)&&(identical(other.bannedUsersCount, bannedUsersCount) || other.bannedUsersCount == bannedUsersCount)&&(identical(other.monthlyVisitorCount, monthlyVisitorCount) || other.monthlyVisitorCount == monthlyVisitorCount)&&(identical(other.weeklyVisitorCount, weeklyVisitorCount) || other.weeklyVisitorCount == weeklyVisitorCount)&&(identical(other.banner, banner) || other.banner == banner)&&(identical(other.bannerHeight, bannerHeight) || other.bannerHeight == bannerHeight)&&(identical(other.bannerWidth, bannerWidth) || other.bannerWidth == bannerWidth)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.profilePictureHeight, profilePictureHeight) || other.profilePictureHeight == profilePictureHeight)&&(identical(other.profilePictureWidth, profilePictureWidth) || other.profilePictureWidth == profilePictureWidth)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl)&&(identical(other.creatorId, creatorId) || other.creatorId == creatorId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,nsfw,private,verified,visibility,const DeepCollectionEquality().hash(_guidelines),memberCount,moderatorCount,bannedUsersCount,monthlyVisitorCount,weeklyVisitorCount,banner,bannerHeight,bannerWidth,bannerUrl,profilePicture,profilePictureHeight,profilePictureWidth,profilePictureUrl,creatorId,createdAt,updatedAt]);

@override
String toString() {
  return 'Community(id: $id, name: $name, description: $description, nsfw: $nsfw, private: $private, verified: $verified, visibility: $visibility, guidelines: $guidelines, memberCount: $memberCount, moderatorCount: $moderatorCount, bannedUsersCount: $bannedUsersCount, monthlyVisitorCount: $monthlyVisitorCount, weeklyVisitorCount: $weeklyVisitorCount, banner: $banner, bannerHeight: $bannerHeight, bannerWidth: $bannerWidth, bannerUrl: $bannerUrl, profilePicture: $profilePicture, profilePictureHeight: $profilePictureHeight, profilePictureWidth: $profilePictureWidth, profilePictureUrl: $profilePictureUrl, creatorId: $creatorId, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityCopyWith<$Res> implements $CommunityCopyWith<$Res> {
  factory _$CommunityCopyWith(_Community value, $Res Function(_Community) _then) = __$CommunityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, bool nsfw, bool private, bool verified, String visibility, List<String> guidelines, int memberCount, int moderatorCount, int bannedUsersCount, int monthlyVisitorCount, int weeklyVisitorCount, String? banner, int bannerHeight, int bannerWidth, String? bannerUrl, String? profilePicture, int profilePictureHeight, int profilePictureWidth, String? profilePictureUrl, String creatorId, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$CommunityCopyWithImpl<$Res>
    implements _$CommunityCopyWith<$Res> {
  __$CommunityCopyWithImpl(this._self, this._then);

  final _Community _self;
  final $Res Function(_Community) _then;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? nsfw = null,Object? private = null,Object? verified = null,Object? visibility = null,Object? guidelines = null,Object? memberCount = null,Object? moderatorCount = null,Object? bannedUsersCount = null,Object? monthlyVisitorCount = null,Object? weeklyVisitorCount = null,Object? banner = freezed,Object? bannerHeight = null,Object? bannerWidth = null,Object? bannerUrl = freezed,Object? profilePicture = freezed,Object? profilePictureHeight = null,Object? profilePictureWidth = null,Object? profilePictureUrl = freezed,Object? creatorId = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Community(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,nsfw: null == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool,private: null == private ? _self.private : private // ignore: cast_nullable_to_non_nullable
as bool,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String,guidelines: null == guidelines ? _self._guidelines : guidelines // ignore: cast_nullable_to_non_nullable
as List<String>,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
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
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

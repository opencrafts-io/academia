// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportApiDto {

 int get id;@JsonKey(name: 'report_type') String get reportType;@JsonKey(name: 'reported_user') String? get reportedUser;@JsonKey(name: 'reported_post') int? get reportedPost;@JsonKey(name: 'reported_comment') int? get reportedComment;@JsonKey(name: 'reported_community') int? get reportedCommunity; String get reason; String get status;@JsonKey(name: 'created_at') DateTime get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of ReportApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportApiDtoCopyWith<ReportApiDto> get copyWith => _$ReportApiDtoCopyWithImpl<ReportApiDto>(this as ReportApiDto, _$identity);

  /// Serializes this ReportApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.reportType, reportType) || other.reportType == reportType)&&(identical(other.reportedUser, reportedUser) || other.reportedUser == reportedUser)&&(identical(other.reportedPost, reportedPost) || other.reportedPost == reportedPost)&&(identical(other.reportedComment, reportedComment) || other.reportedComment == reportedComment)&&(identical(other.reportedCommunity, reportedCommunity) || other.reportedCommunity == reportedCommunity)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reportType,reportedUser,reportedPost,reportedComment,reportedCommunity,reason,status,createdAt,updatedAt);

@override
String toString() {
  return 'ReportApiDto(id: $id, reportType: $reportType, reportedUser: $reportedUser, reportedPost: $reportedPost, reportedComment: $reportedComment, reportedCommunity: $reportedCommunity, reason: $reason, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ReportApiDtoCopyWith<$Res>  {
  factory $ReportApiDtoCopyWith(ReportApiDto value, $Res Function(ReportApiDto) _then) = _$ReportApiDtoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'report_type') String reportType,@JsonKey(name: 'reported_user') String? reportedUser,@JsonKey(name: 'reported_post') int? reportedPost,@JsonKey(name: 'reported_comment') int? reportedComment,@JsonKey(name: 'reported_community') int? reportedCommunity, String reason, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$ReportApiDtoCopyWithImpl<$Res>
    implements $ReportApiDtoCopyWith<$Res> {
  _$ReportApiDtoCopyWithImpl(this._self, this._then);

  final ReportApiDto _self;
  final $Res Function(ReportApiDto) _then;

/// Create a copy of ReportApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reportType = null,Object? reportedUser = freezed,Object? reportedPost = freezed,Object? reportedComment = freezed,Object? reportedCommunity = freezed,Object? reason = null,Object? status = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,reportType: null == reportType ? _self.reportType : reportType // ignore: cast_nullable_to_non_nullable
as String,reportedUser: freezed == reportedUser ? _self.reportedUser : reportedUser // ignore: cast_nullable_to_non_nullable
as String?,reportedPost: freezed == reportedPost ? _self.reportedPost : reportedPost // ignore: cast_nullable_to_non_nullable
as int?,reportedComment: freezed == reportedComment ? _self.reportedComment : reportedComment // ignore: cast_nullable_to_non_nullable
as int?,reportedCommunity: freezed == reportedCommunity ? _self.reportedCommunity : reportedCommunity // ignore: cast_nullable_to_non_nullable
as int?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportApiDto].
extension ReportApiDtoPatterns on ReportApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportApiDto value)  $default,){
final _that = this;
switch (_that) {
case _ReportApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReportApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'report_type')  String reportType, @JsonKey(name: 'reported_user')  String? reportedUser, @JsonKey(name: 'reported_post')  int? reportedPost, @JsonKey(name: 'reported_comment')  int? reportedComment, @JsonKey(name: 'reported_community')  int? reportedCommunity,  String reason,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportApiDto() when $default != null:
return $default(_that.id,_that.reportType,_that.reportedUser,_that.reportedPost,_that.reportedComment,_that.reportedCommunity,_that.reason,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'report_type')  String reportType, @JsonKey(name: 'reported_user')  String? reportedUser, @JsonKey(name: 'reported_post')  int? reportedPost, @JsonKey(name: 'reported_comment')  int? reportedComment, @JsonKey(name: 'reported_community')  int? reportedCommunity,  String reason,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ReportApiDto():
return $default(_that.id,_that.reportType,_that.reportedUser,_that.reportedPost,_that.reportedComment,_that.reportedCommunity,_that.reason,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'report_type')  String reportType, @JsonKey(name: 'reported_user')  String? reportedUser, @JsonKey(name: 'reported_post')  int? reportedPost, @JsonKey(name: 'reported_comment')  int? reportedComment, @JsonKey(name: 'reported_community')  int? reportedCommunity,  String reason,  String status, @JsonKey(name: 'created_at')  DateTime createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReportApiDto() when $default != null:
return $default(_that.id,_that.reportType,_that.reportedUser,_that.reportedPost,_that.reportedComment,_that.reportedCommunity,_that.reason,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportApiDto implements ReportApiDto {
  const _ReportApiDto({required this.id, @JsonKey(name: 'report_type') required this.reportType, @JsonKey(name: 'reported_user') this.reportedUser, @JsonKey(name: 'reported_post') this.reportedPost, @JsonKey(name: 'reported_comment') this.reportedComment, @JsonKey(name: 'reported_community') this.reportedCommunity, required this.reason, required this.status, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _ReportApiDto.fromJson(Map<String, dynamic> json) => _$ReportApiDtoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'report_type') final  String reportType;
@override@JsonKey(name: 'reported_user') final  String? reportedUser;
@override@JsonKey(name: 'reported_post') final  int? reportedPost;
@override@JsonKey(name: 'reported_comment') final  int? reportedComment;
@override@JsonKey(name: 'reported_community') final  int? reportedCommunity;
@override final  String reason;
@override final  String status;
@override@JsonKey(name: 'created_at') final  DateTime createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of ReportApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportApiDtoCopyWith<_ReportApiDto> get copyWith => __$ReportApiDtoCopyWithImpl<_ReportApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportApiDto&&(identical(other.id, id) || other.id == id)&&(identical(other.reportType, reportType) || other.reportType == reportType)&&(identical(other.reportedUser, reportedUser) || other.reportedUser == reportedUser)&&(identical(other.reportedPost, reportedPost) || other.reportedPost == reportedPost)&&(identical(other.reportedComment, reportedComment) || other.reportedComment == reportedComment)&&(identical(other.reportedCommunity, reportedCommunity) || other.reportedCommunity == reportedCommunity)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,reportType,reportedUser,reportedPost,reportedComment,reportedCommunity,reason,status,createdAt,updatedAt);

@override
String toString() {
  return 'ReportApiDto(id: $id, reportType: $reportType, reportedUser: $reportedUser, reportedPost: $reportedPost, reportedComment: $reportedComment, reportedCommunity: $reportedCommunity, reason: $reason, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ReportApiDtoCopyWith<$Res> implements $ReportApiDtoCopyWith<$Res> {
  factory _$ReportApiDtoCopyWith(_ReportApiDto value, $Res Function(_ReportApiDto) _then) = __$ReportApiDtoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'report_type') String reportType,@JsonKey(name: 'reported_user') String? reportedUser,@JsonKey(name: 'reported_post') int? reportedPost,@JsonKey(name: 'reported_comment') int? reportedComment,@JsonKey(name: 'reported_community') int? reportedCommunity, String reason, String status,@JsonKey(name: 'created_at') DateTime createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$ReportApiDtoCopyWithImpl<$Res>
    implements _$ReportApiDtoCopyWith<$Res> {
  __$ReportApiDtoCopyWithImpl(this._self, this._then);

  final _ReportApiDto _self;
  final $Res Function(_ReportApiDto) _then;

/// Create a copy of ReportApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reportType = null,Object? reportedUser = freezed,Object? reportedPost = freezed,Object? reportedComment = freezed,Object? reportedCommunity = freezed,Object? reason = null,Object? status = null,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_ReportApiDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,reportType: null == reportType ? _self.reportType : reportType // ignore: cast_nullable_to_non_nullable
as String,reportedUser: freezed == reportedUser ? _self.reportedUser : reportedUser // ignore: cast_nullable_to_non_nullable
as String?,reportedPost: freezed == reportedPost ? _self.reportedPost : reportedPost // ignore: cast_nullable_to_non_nullable
as int?,reportedComment: freezed == reportedComment ? _self.reportedComment : reportedComment // ignore: cast_nullable_to_non_nullable
as int?,reportedCommunity: freezed == reportedCommunity ? _self.reportedCommunity : reportedCommunity // ignore: cast_nullable_to_non_nullable
as int?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

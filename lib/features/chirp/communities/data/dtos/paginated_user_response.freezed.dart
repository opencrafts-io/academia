// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaginatedUserResponse {

 int get count; String? get next; String? get previous; List<CommunityUserApiDto> get users;
/// Create a copy of PaginatedUserResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedUserResponseCopyWith<PaginatedUserResponse> get copyWith => _$PaginatedUserResponseCopyWithImpl<PaginatedUserResponse>(this as PaginatedUserResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedUserResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other.users, users));
}


@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(users));

@override
String toString() {
  return 'PaginatedUserResponse(count: $count, next: $next, previous: $previous, users: $users)';
}


}

/// @nodoc
abstract mixin class $PaginatedUserResponseCopyWith<$Res>  {
  factory $PaginatedUserResponseCopyWith(PaginatedUserResponse value, $Res Function(PaginatedUserResponse) _then) = _$PaginatedUserResponseCopyWithImpl;
@useResult
$Res call({
 int count, String? next, String? previous, List<CommunityUserApiDto> users
});




}
/// @nodoc
class _$PaginatedUserResponseCopyWithImpl<$Res>
    implements $PaginatedUserResponseCopyWith<$Res> {
  _$PaginatedUserResponseCopyWithImpl(this._self, this._then);

  final PaginatedUserResponse _self;
  final $Res Function(PaginatedUserResponse) _then;

/// Create a copy of PaginatedUserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? users = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<CommunityUserApiDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedUserResponse].
extension PaginatedUserResponsePatterns on PaginatedUserResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedUserResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedUserResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedUserResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedUserResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedUserResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedUserResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<CommunityUserApiDto> users)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedUserResponse() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.users);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<CommunityUserApiDto> users)  $default,) {final _that = this;
switch (_that) {
case _PaginatedUserResponse():
return $default(_that.count,_that.next,_that.previous,_that.users);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  String? next,  String? previous,  List<CommunityUserApiDto> users)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedUserResponse() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.users);case _:
  return null;

}
}

}

/// @nodoc


class _PaginatedUserResponse implements PaginatedUserResponse {
  const _PaginatedUserResponse({required this.count, this.next, this.previous, required final  List<CommunityUserApiDto> users}): _users = users;
  

@override final  int count;
@override final  String? next;
@override final  String? previous;
 final  List<CommunityUserApiDto> _users;
@override List<CommunityUserApiDto> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}


/// Create a copy of PaginatedUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedUserResponseCopyWith<_PaginatedUserResponse> get copyWith => __$PaginatedUserResponseCopyWithImpl<_PaginatedUserResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedUserResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other._users, _users));
}


@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(_users));

@override
String toString() {
  return 'PaginatedUserResponse(count: $count, next: $next, previous: $previous, users: $users)';
}


}

/// @nodoc
abstract mixin class _$PaginatedUserResponseCopyWith<$Res> implements $PaginatedUserResponseCopyWith<$Res> {
  factory _$PaginatedUserResponseCopyWith(_PaginatedUserResponse value, $Res Function(_PaginatedUserResponse) _then) = __$PaginatedUserResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, String? next, String? previous, List<CommunityUserApiDto> users
});




}
/// @nodoc
class __$PaginatedUserResponseCopyWithImpl<$Res>
    implements _$PaginatedUserResponseCopyWith<$Res> {
  __$PaginatedUserResponseCopyWithImpl(this._self, this._then);

  final _PaginatedUserResponse _self;
  final $Res Function(_PaginatedUserResponse) _then;

/// Create a copy of PaginatedUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? users = null,}) {
  return _then(_PaginatedUserResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<CommunityUserApiDto>,
  ));
}


}

// dart format on

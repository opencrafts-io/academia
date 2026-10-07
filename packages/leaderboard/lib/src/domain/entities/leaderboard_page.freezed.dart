// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LeaderboardPage {

 List<LeaderboardEntry> get entries; int get totalUsers; int? get userPosition; bool get hasNext; int get currentPage;
/// Create a copy of LeaderboardPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeaderboardPageCopyWith<LeaderboardPage> get copyWith => _$LeaderboardPageCopyWithImpl<LeaderboardPage>(this as LeaderboardPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LeaderboardPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeaderboardPage&&const DeepCollectionEquality().equals(other.entries, _this.entries)&&(identical(other.totalUsers, _this.totalUsers) || other.totalUsers == _this.totalUsers)&&(identical(other.userPosition, _this.userPosition) || other.userPosition == _this.userPosition)&&(identical(other.hasNext, _this.hasNext) || other.hasNext == _this.hasNext)&&(identical(other.currentPage, _this.currentPage) || other.currentPage == _this.currentPage));
}


@override
int get hashCode {
  final _this = this as LeaderboardPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.entries),_this.totalUsers,_this.userPosition,_this.hasNext,_this.currentPage);
}

@override
String toString() {
  final _this = this as LeaderboardPage;
  return 'LeaderboardPage(entries: ${_this.entries}, totalUsers: ${_this.totalUsers}, userPosition: ${_this.userPosition}, hasNext: ${_this.hasNext}, currentPage: ${_this.currentPage})';
}


}

/// @nodoc
abstract mixin class $LeaderboardPageCopyWith<$Res>  {
  factory $LeaderboardPageCopyWith(LeaderboardPage value, $Res Function(LeaderboardPage) _then) = _$LeaderboardPageCopyWithImpl;
@useResult
$Res call({
 List<LeaderboardEntry> entries, int totalUsers, int? userPosition, bool hasNext, int currentPage
});




}
/// @nodoc
class _$LeaderboardPageCopyWithImpl<$Res>
    implements $LeaderboardPageCopyWith<$Res> {
  _$LeaderboardPageCopyWithImpl(this._self, this._then);

  final LeaderboardPage _self;
  final $Res Function(LeaderboardPage) _then;

/// Create a copy of LeaderboardPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,Object? totalUsers = null,Object? userPosition = freezed,Object? hasNext = null,Object? currentPage = null,}) {
  return _then(LeaderboardPage(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntry>,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,userPosition: freezed == userPosition ? _self.userPosition : userPosition // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LeaderboardPage].
extension LeaderboardPagePatterns on LeaderboardPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LeaderboardPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LeaderboardPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LeaderboardPage value)  $default,){
final _that = this;
switch (_that) {
case _LeaderboardPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LeaderboardPage value)?  $default,){
final _that = this;
switch (_that) {
case _LeaderboardPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LeaderboardEntry> entries,  int totalUsers,  int? userPosition,  bool hasNext,  int currentPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LeaderboardPage() when $default != null:
return $default(_that.entries,_that.totalUsers,_that.userPosition,_that.hasNext,_that.currentPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LeaderboardEntry> entries,  int totalUsers,  int? userPosition,  bool hasNext,  int currentPage)  $default,) {final _that = this;
switch (_that) {
case _LeaderboardPage():
return $default(_that.entries,_that.totalUsers,_that.userPosition,_that.hasNext,_that.currentPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LeaderboardEntry> entries,  int totalUsers,  int? userPosition,  bool hasNext,  int currentPage)?  $default,) {final _that = this;
switch (_that) {
case _LeaderboardPage() when $default != null:
return $default(_that.entries,_that.totalUsers,_that.userPosition,_that.hasNext,_that.currentPage);case _:
  return null;

}
}

}

/// @nodoc


class _LeaderboardPage implements LeaderboardPage {
  const _LeaderboardPage({required  List<LeaderboardEntry> entries, required this.totalUsers, this.userPosition, required this.hasNext, required this.currentPage}): _entries = entries;


 final  List<LeaderboardEntry> _entries;
@override List<LeaderboardEntry> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override final  int totalUsers;
@override final  int? userPosition;
@override final  bool hasNext;
@override final  int currentPage;

/// Create a copy of LeaderboardPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LeaderboardPageCopyWith<_LeaderboardPage> get copyWith => __$LeaderboardPageCopyWithImpl<_LeaderboardPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LeaderboardPage&&const DeepCollectionEquality().equals(other.entries, _entries)&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.userPosition, userPosition) || other.userPosition == userPosition)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),totalUsers,userPosition,hasNext,currentPage);
}

@override
String toString() {
    return 'LeaderboardPage(entries: $entries, totalUsers: $totalUsers, userPosition: $userPosition, hasNext: $hasNext, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class _$LeaderboardPageCopyWith<$Res> implements $LeaderboardPageCopyWith<$Res> {
  factory _$LeaderboardPageCopyWith(_LeaderboardPage value, $Res Function(_LeaderboardPage) _then) = __$LeaderboardPageCopyWithImpl;
@override @useResult
$Res call({
 List<LeaderboardEntry> entries, int totalUsers, int? userPosition, bool hasNext, int currentPage
});




}
/// @nodoc
class __$LeaderboardPageCopyWithImpl<$Res>
    implements _$LeaderboardPageCopyWith<$Res> {
  __$LeaderboardPageCopyWithImpl(this._self, this._then);

  final _LeaderboardPage _self;
  final $Res Function(_LeaderboardPage) _then;

/// Create a copy of LeaderboardPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? totalUsers = null,Object? userPosition = freezed,Object? hasNext = null,Object? currentPage = null,}) {
  return _then(_LeaderboardPage(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<LeaderboardEntry>,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,userPosition: freezed == userPosition ? _self.userPosition : userPosition // ignore: cast_nullable_to_non_nullable
as int?,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

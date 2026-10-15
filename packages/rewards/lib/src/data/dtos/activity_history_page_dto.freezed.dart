// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_history_page_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityHistoryPageDto {

 int get count; String? get next; String? get previous; List<ActivityHistoryDto> get results;
/// Create a copy of ActivityHistoryPageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityHistoryPageDtoCopyWith<ActivityHistoryPageDto> get copyWith => _$ActivityHistoryPageDtoCopyWithImpl<ActivityHistoryPageDto>(this as ActivityHistoryPageDto, _$identity);

  /// Serializes this ActivityHistoryPageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ActivityHistoryPageDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityHistoryPageDto&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.next, _this.next) || other.next == _this.next)&&(identical(other.previous, _this.previous) || other.previous == _this.previous)&&const DeepCollectionEquality().equals(other.results, _this.results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ActivityHistoryPageDto;
  return Object.hash(runtimeType,_this.count,_this.next,_this.previous,const DeepCollectionEquality().hash(_this.results));
}

@override
String toString() {
  final _this = this as ActivityHistoryPageDto;
  return 'ActivityHistoryPageDto(count: ${_this.count}, next: ${_this.next}, previous: ${_this.previous}, results: ${_this.results})';
}


}

/// @nodoc
abstract mixin class $ActivityHistoryPageDtoCopyWith<$Res>  {
  factory $ActivityHistoryPageDtoCopyWith(ActivityHistoryPageDto value, $Res Function(ActivityHistoryPageDto) _then) = _$ActivityHistoryPageDtoCopyWithImpl;
@useResult
$Res call({
 int count, String? next, String? previous, List<ActivityHistoryDto> results
});




}
/// @nodoc
class _$ActivityHistoryPageDtoCopyWithImpl<$Res>
    implements $ActivityHistoryPageDtoCopyWith<$Res> {
  _$ActivityHistoryPageDtoCopyWithImpl(this._self, this._then);

  final ActivityHistoryPageDto _self;
  final $Res Function(ActivityHistoryPageDto) _then;

/// Create a copy of ActivityHistoryPageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(ActivityHistoryPageDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<ActivityHistoryDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityHistoryPageDto].
extension ActivityHistoryPageDtoPatterns on ActivityHistoryPageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityHistoryPageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityHistoryPageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityHistoryPageDto value)  $default,){
final _that = this;
switch (_that) {
case _ActivityHistoryPageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityHistoryPageDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityHistoryPageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<ActivityHistoryDto> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityHistoryPageDto() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<ActivityHistoryDto> results)  $default,) {final _that = this;
switch (_that) {
case _ActivityHistoryPageDto():
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  String? next,  String? previous,  List<ActivityHistoryDto> results)?  $default,) {final _that = this;
switch (_that) {
case _ActivityHistoryPageDto() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityHistoryPageDto implements ActivityHistoryPageDto {
  const _ActivityHistoryPageDto({this.count = 0, this.next, this.previous,  List<ActivityHistoryDto> results = const <ActivityHistoryDto>[]}): _results = results;
  factory _ActivityHistoryPageDto.fromJson(Map<String, dynamic> json) => _$ActivityHistoryPageDtoFromJson(json);

@override@JsonKey() final  int count;
@override final  String? next;
@override final  String? previous;
 final  List<ActivityHistoryDto> _results;
@override@JsonKey() List<ActivityHistoryDto> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of ActivityHistoryPageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityHistoryPageDtoCopyWith<_ActivityHistoryPageDto> get copyWith => __$ActivityHistoryPageDtoCopyWithImpl<_ActivityHistoryPageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityHistoryPageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityHistoryPageDto&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other.results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(_results));
}

@override
String toString() {
    return 'ActivityHistoryPageDto(count: $count, next: $next, previous: $previous, results: $results)';
}


}

/// @nodoc
abstract mixin class _$ActivityHistoryPageDtoCopyWith<$Res> implements $ActivityHistoryPageDtoCopyWith<$Res> {
  factory _$ActivityHistoryPageDtoCopyWith(_ActivityHistoryPageDto value, $Res Function(_ActivityHistoryPageDto) _then) = __$ActivityHistoryPageDtoCopyWithImpl;
@override @useResult
$Res call({
 int count, String? next, String? previous, List<ActivityHistoryDto> results
});




}
/// @nodoc
class __$ActivityHistoryPageDtoCopyWithImpl<$Res>
    implements _$ActivityHistoryPageDtoCopyWith<$Res> {
  __$ActivityHistoryPageDtoCopyWithImpl(this._self, this._then);

  final _ActivityHistoryPageDto _self;
  final $Res Function(_ActivityHistoryPageDto) _then;

/// Create a copy of ActivityHistoryPageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(_ActivityHistoryPageDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<ActivityHistoryDto>,
  ));
}


}

// dart format on

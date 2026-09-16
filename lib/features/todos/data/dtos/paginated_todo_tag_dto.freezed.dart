// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_todo_tag_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedTodoTagDto {

 int get count; String? get next; String? get previous; List<TodoTagDto> get results;
/// Create a copy of PaginatedTodoTagDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedTodoTagDtoCopyWith<PaginatedTodoTagDto> get copyWith => _$PaginatedTodoTagDtoCopyWithImpl<PaginatedTodoTagDto>(this as PaginatedTodoTagDto, _$identity);

  /// Serializes this PaginatedTodoTagDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedTodoTagDto&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'PaginatedTodoTagDto(count: $count, next: $next, previous: $previous, results: $results)';
}


}

/// @nodoc
abstract mixin class $PaginatedTodoTagDtoCopyWith<$Res>  {
  factory $PaginatedTodoTagDtoCopyWith(PaginatedTodoTagDto value, $Res Function(PaginatedTodoTagDto) _then) = _$PaginatedTodoTagDtoCopyWithImpl;
@useResult
$Res call({
 int count, String? next, String? previous, List<TodoTagDto> results
});




}
/// @nodoc
class _$PaginatedTodoTagDtoCopyWithImpl<$Res>
    implements $PaginatedTodoTagDtoCopyWith<$Res> {
  _$PaginatedTodoTagDtoCopyWithImpl(this._self, this._then);

  final PaginatedTodoTagDto _self;
  final $Res Function(PaginatedTodoTagDto) _then;

/// Create a copy of PaginatedTodoTagDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<TodoTagDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedTodoTagDto].
extension PaginatedTodoTagDtoPatterns on PaginatedTodoTagDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedTodoTagDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedTodoTagDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedTodoTagDto value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedTodoTagDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedTodoTagDto value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedTodoTagDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<TodoTagDto> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedTodoTagDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<TodoTagDto> results)  $default,) {final _that = this;
switch (_that) {
case _PaginatedTodoTagDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  String? next,  String? previous,  List<TodoTagDto> results)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedTodoTagDto() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedTodoTagDto implements PaginatedTodoTagDto {
  const _PaginatedTodoTagDto({required this.count, required this.next, required this.previous, required final  List<TodoTagDto> results}): _results = results;
  factory _PaginatedTodoTagDto.fromJson(Map<String, dynamic> json) => _$PaginatedTodoTagDtoFromJson(json);

@override final  int count;
@override final  String? next;
@override final  String? previous;
 final  List<TodoTagDto> _results;
@override List<TodoTagDto> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of PaginatedTodoTagDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedTodoTagDtoCopyWith<_PaginatedTodoTagDto> get copyWith => __$PaginatedTodoTagDtoCopyWithImpl<_PaginatedTodoTagDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedTodoTagDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedTodoTagDto&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'PaginatedTodoTagDto(count: $count, next: $next, previous: $previous, results: $results)';
}


}

/// @nodoc
abstract mixin class _$PaginatedTodoTagDtoCopyWith<$Res> implements $PaginatedTodoTagDtoCopyWith<$Res> {
  factory _$PaginatedTodoTagDtoCopyWith(_PaginatedTodoTagDto value, $Res Function(_PaginatedTodoTagDto) _then) = __$PaginatedTodoTagDtoCopyWithImpl;
@override @useResult
$Res call({
 int count, String? next, String? previous, List<TodoTagDto> results
});




}
/// @nodoc
class __$PaginatedTodoTagDtoCopyWithImpl<$Res>
    implements _$PaginatedTodoTagDtoCopyWith<$Res> {
  __$PaginatedTodoTagDtoCopyWithImpl(this._self, this._then);

  final _PaginatedTodoTagDto _self;
  final $Res Function(_PaginatedTodoTagDto) _then;

/// Create a copy of PaginatedTodoTagDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(_PaginatedTodoTagDto(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<TodoTagDto>,
  ));
}


}

// dart format on

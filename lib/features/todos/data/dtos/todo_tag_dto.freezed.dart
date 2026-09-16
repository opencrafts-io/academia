// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_tag_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoTagDto {

 String? get id; String get name; String? get color;@JsonKey(name: 'created_at') String? get createdAt;
/// Create a copy of TodoTagDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoTagDtoCopyWith<TodoTagDto> get copyWith => _$TodoTagDtoCopyWithImpl<TodoTagDto>(this as TodoTagDto, _$identity);

  /// Serializes this TodoTagDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoTagDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,createdAt);

@override
String toString() {
  return 'TodoTagDto(id: $id, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TodoTagDtoCopyWith<$Res>  {
  factory $TodoTagDtoCopyWith(TodoTagDto value, $Res Function(TodoTagDto) _then) = _$TodoTagDtoCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String? color,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class _$TodoTagDtoCopyWithImpl<$Res>
    implements $TodoTagDtoCopyWith<$Res> {
  _$TodoTagDtoCopyWithImpl(this._self, this._then);

  final TodoTagDto _self;
  final $Res Function(TodoTagDto) _then;

/// Create a copy of TodoTagDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? color = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodoTagDto].
extension TodoTagDtoPatterns on TodoTagDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodoTagDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodoTagDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodoTagDto value)  $default,){
final _that = this;
switch (_that) {
case _TodoTagDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodoTagDto value)?  $default,){
final _that = this;
switch (_that) {
case _TodoTagDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String name,  String? color, @JsonKey(name: 'created_at')  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodoTagDto() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String name,  String? color, @JsonKey(name: 'created_at')  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TodoTagDto():
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String name,  String? color, @JsonKey(name: 'created_at')  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TodoTagDto() when $default != null:
return $default(_that.id,_that.name,_that.color,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodoTagDto implements TodoTagDto {
  const _TodoTagDto({required this.id, required this.name, required this.color, @JsonKey(name: 'created_at') required this.createdAt});
  factory _TodoTagDto.fromJson(Map<String, dynamic> json) => _$TodoTagDtoFromJson(json);

@override final  String? id;
@override final  String name;
@override final  String? color;
@override@JsonKey(name: 'created_at') final  String? createdAt;

/// Create a copy of TodoTagDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodoTagDtoCopyWith<_TodoTagDto> get copyWith => __$TodoTagDtoCopyWithImpl<_TodoTagDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodoTagDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodoTagDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,createdAt);

@override
String toString() {
  return 'TodoTagDto(id: $id, name: $name, color: $color, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TodoTagDtoCopyWith<$Res> implements $TodoTagDtoCopyWith<$Res> {
  factory _$TodoTagDtoCopyWith(_TodoTagDto value, $Res Function(_TodoTagDto) _then) = __$TodoTagDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String name, String? color,@JsonKey(name: 'created_at') String? createdAt
});




}
/// @nodoc
class __$TodoTagDtoCopyWithImpl<$Res>
    implements _$TodoTagDtoCopyWith<$Res> {
  __$TodoTagDtoCopyWithImpl(this._self, this._then);

  final _TodoTagDto _self;
  final $Res Function(_TodoTagDto) _then;

/// Create a copy of TodoTagDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? color = freezed,Object? createdAt = freezed,}) {
  return _then(_TodoTagDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

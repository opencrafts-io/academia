// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lecturer_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LecturerDto {

 String get id; String get name; String? get email; String? get phone; String? get office;
/// Create a copy of LecturerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LecturerDtoCopyWith<LecturerDto> get copyWith => _$LecturerDtoCopyWithImpl<LecturerDto>(this as LecturerDto, _$identity);

  /// Serializes this LecturerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LecturerDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LecturerDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.office, _this.office) || other.office == _this.office));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LecturerDto;
  return Object.hash(runtimeType,_this.id,_this.name,_this.email,_this.phone,_this.office);
}

@override
String toString() {
  final _this = this as LecturerDto;
  return 'LecturerDto(id: ${_this.id}, name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, office: ${_this.office})';
}


}

/// @nodoc
abstract mixin class $LecturerDtoCopyWith<$Res>  {
  factory $LecturerDtoCopyWith(LecturerDto value, $Res Function(LecturerDto) _then) = _$LecturerDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? email, String? phone, String? office
});




}
/// @nodoc
class _$LecturerDtoCopyWithImpl<$Res>
    implements $LecturerDtoCopyWith<$Res> {
  _$LecturerDtoCopyWithImpl(this._self, this._then);

  final LecturerDto _self;
  final $Res Function(LecturerDto) _then;

/// Create a copy of LecturerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? phone = freezed,Object? office = freezed,}) {
  return _then(LecturerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,office: freezed == office ? _self.office : office // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LecturerDto].
extension LecturerDtoPatterns on LecturerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LecturerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LecturerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LecturerDto value)  $default,){
final _that = this;
switch (_that) {
case _LecturerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LecturerDto value)?  $default,){
final _that = this;
switch (_that) {
case _LecturerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? email,  String? phone,  String? office)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LecturerDto() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.office);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? email,  String? phone,  String? office)  $default,) {final _that = this;
switch (_that) {
case _LecturerDto():
return $default(_that.id,_that.name,_that.email,_that.phone,_that.office);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? email,  String? phone,  String? office)?  $default,) {final _that = this;
switch (_that) {
case _LecturerDto() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.office);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LecturerDto implements LecturerDto {
  const _LecturerDto({required this.id, required this.name, this.email, this.phone, this.office});
  factory _LecturerDto.fromJson(Map<String, dynamic> json) => _$LecturerDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? email;
@override final  String? phone;
@override final  String? office;

/// Create a copy of LecturerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LecturerDtoCopyWith<_LecturerDto> get copyWith => __$LecturerDtoCopyWithImpl<_LecturerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LecturerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LecturerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.office, office) || other.office == office));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,email,phone,office);
}

@override
String toString() {
    return 'LecturerDto(id: $id, name: $name, email: $email, phone: $phone, office: $office)';
}


}

/// @nodoc
abstract mixin class _$LecturerDtoCopyWith<$Res> implements $LecturerDtoCopyWith<$Res> {
  factory _$LecturerDtoCopyWith(_LecturerDto value, $Res Function(_LecturerDto) _then) = __$LecturerDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? email, String? phone, String? office
});




}
/// @nodoc
class __$LecturerDtoCopyWithImpl<$Res>
    implements _$LecturerDtoCopyWith<$Res> {
  __$LecturerDtoCopyWithImpl(this._self, this._then);

  final _LecturerDto _self;
  final $Res Function(_LecturerDto) _then;

/// Create a copy of LecturerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? phone = freezed,Object? office = freezed,}) {
  return _then(_LecturerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,office: freezed == office ? _self.office : office // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

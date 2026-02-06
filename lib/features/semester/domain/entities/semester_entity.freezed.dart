// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'semester_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SemesterEntity {

 int get id; String get name; String? get description; int? get institutionId; DateTime get startDate; DateTime get endDate;
/// Create a copy of SemesterEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SemesterEntityCopyWith<SemesterEntity> get copyWith => _$SemesterEntityCopyWithImpl<SemesterEntity>(this as SemesterEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SemesterEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,institutionId,startDate,endDate);

@override
String toString() {
  return 'SemesterEntity(id: $id, name: $name, description: $description, institutionId: $institutionId, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $SemesterEntityCopyWith<$Res>  {
  factory $SemesterEntityCopyWith(SemesterEntity value, $Res Function(SemesterEntity) _then) = _$SemesterEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, int? institutionId, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class _$SemesterEntityCopyWithImpl<$Res>
    implements $SemesterEntityCopyWith<$Res> {
  _$SemesterEntityCopyWithImpl(this._self, this._then);

  final SemesterEntity _self;
  final $Res Function(SemesterEntity) _then;

/// Create a copy of SemesterEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? institutionId = freezed,Object? startDate = null,Object? endDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SemesterEntity].
extension SemesterEntityPatterns on SemesterEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SemesterEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SemesterEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SemesterEntity value)  $default,){
final _that = this;
switch (_that) {
case _SemesterEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SemesterEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SemesterEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  int? institutionId,  DateTime startDate,  DateTime endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SemesterEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.institutionId,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  int? institutionId,  DateTime startDate,  DateTime endDate)  $default,) {final _that = this;
switch (_that) {
case _SemesterEntity():
return $default(_that.id,_that.name,_that.description,_that.institutionId,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  int? institutionId,  DateTime startDate,  DateTime endDate)?  $default,) {final _that = this;
switch (_that) {
case _SemesterEntity() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.institutionId,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc


class _SemesterEntity implements SemesterEntity {
  const _SemesterEntity({required this.id, required this.name, this.description, this.institutionId, required this.startDate, required this.endDate});
  

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  int? institutionId;
@override final  DateTime startDate;
@override final  DateTime endDate;

/// Create a copy of SemesterEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SemesterEntityCopyWith<_SemesterEntity> get copyWith => __$SemesterEntityCopyWithImpl<_SemesterEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SemesterEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,institutionId,startDate,endDate);

@override
String toString() {
  return 'SemesterEntity(id: $id, name: $name, description: $description, institutionId: $institutionId, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$SemesterEntityCopyWith<$Res> implements $SemesterEntityCopyWith<$Res> {
  factory _$SemesterEntityCopyWith(_SemesterEntity value, $Res Function(_SemesterEntity) _then) = __$SemesterEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, int? institutionId, DateTime startDate, DateTime endDate
});




}
/// @nodoc
class __$SemesterEntityCopyWithImpl<$Res>
    implements _$SemesterEntityCopyWith<$Res> {
  __$SemesterEntityCopyWithImpl(this._self, this._then);

  final _SemesterEntity _self;
  final $Res Function(_SemesterEntity) _then;

/// Create a copy of SemesterEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? institutionId = freezed,Object? startDate = null,Object? endDate = null,}) {
  return _then(_SemesterEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,institutionId: freezed == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

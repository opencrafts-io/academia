// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardAccount {

 String get id; int get vibePoints;
/// Create a copy of RewardAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardAccountCopyWith<RewardAccount> get copyWith => _$RewardAccountCopyWithImpl<RewardAccount>(this as RewardAccount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RewardAccount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardAccount&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.vibePoints, _this.vibePoints) || other.vibePoints == _this.vibePoints));
}


@override
int get hashCode {
  final _this = this as RewardAccount;
  return Object.hash(runtimeType,_this.id,_this.vibePoints);
}

@override
String toString() {
  final _this = this as RewardAccount;
  return 'RewardAccount(id: ${_this.id}, vibePoints: ${_this.vibePoints})';
}


}

/// @nodoc
abstract mixin class $RewardAccountCopyWith<$Res>  {
  factory $RewardAccountCopyWith(RewardAccount value, $Res Function(RewardAccount) _then) = _$RewardAccountCopyWithImpl;
@useResult
$Res call({
 String id, int vibePoints
});




}
/// @nodoc
class _$RewardAccountCopyWithImpl<$Res>
    implements $RewardAccountCopyWith<$Res> {
  _$RewardAccountCopyWithImpl(this._self, this._then);

  final RewardAccount _self;
  final $Res Function(RewardAccount) _then;

/// Create a copy of RewardAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vibePoints = null,}) {
  return _then(RewardAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardAccount].
extension RewardAccountPatterns on RewardAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardAccount value)  $default,){
final _that = this;
switch (_that) {
case _RewardAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardAccount value)?  $default,){
final _that = this;
switch (_that) {
case _RewardAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int vibePoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardAccount() when $default != null:
return $default(_that.id,_that.vibePoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int vibePoints)  $default,) {final _that = this;
switch (_that) {
case _RewardAccount():
return $default(_that.id,_that.vibePoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int vibePoints)?  $default,) {final _that = this;
switch (_that) {
case _RewardAccount() when $default != null:
return $default(_that.id,_that.vibePoints);case _:
  return null;

}
}

}

/// @nodoc


class _RewardAccount implements RewardAccount {
  const _RewardAccount({required this.id, required this.vibePoints});


@override final  String id;
@override final  int vibePoints;

/// Create a copy of RewardAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardAccountCopyWith<_RewardAccount> get copyWith => __$RewardAccountCopyWithImpl<_RewardAccount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.vibePoints, vibePoints) || other.vibePoints == vibePoints));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,vibePoints);
}

@override
String toString() {
    return 'RewardAccount(id: $id, vibePoints: $vibePoints)';
}


}

/// @nodoc
abstract mixin class _$RewardAccountCopyWith<$Res> implements $RewardAccountCopyWith<$Res> {
  factory _$RewardAccountCopyWith(_RewardAccount value, $Res Function(_RewardAccount) _then) = __$RewardAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, int vibePoints
});




}
/// @nodoc
class __$RewardAccountCopyWithImpl<$Res>
    implements _$RewardAccountCopyWith<$Res> {
  __$RewardAccountCopyWithImpl(this._self, this._then);

  final _RewardAccount _self;
  final $Res Function(_RewardAccount) _then;

/// Create a copy of RewardAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vibePoints = null,}) {
  return _then(_RewardAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vibePoints: null == vibePoints ? _self.vibePoints : vibePoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

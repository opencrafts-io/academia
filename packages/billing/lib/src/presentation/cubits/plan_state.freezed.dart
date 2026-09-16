// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PlanState()';
}


}

/// @nodoc
class $PlanStateCopyWith<$Res>  {
$PlanStateCopyWith(PlanState _, $Res Function(PlanState) __);
}


/// Adds pattern-matching-related methods to [PlanState].
extension PlanStatePatterns on PlanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _PlansLoaded value)?  plansLoaded,TResult Function( _PlanLoaded value)?  planLoaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _PlansLoaded() when plansLoaded != null:
return plansLoaded(_that);case _PlanLoaded() when planLoaded != null:
return planLoaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _PlansLoaded value)  plansLoaded,required TResult Function( _PlanLoaded value)  planLoaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _PlansLoaded():
return plansLoaded(_that);case _PlanLoaded():
return planLoaded(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _PlansLoaded value)?  plansLoaded,TResult? Function( _PlanLoaded value)?  planLoaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _PlansLoaded() when plansLoaded != null:
return plansLoaded(_that);case _PlanLoaded() when planLoaded != null:
return planLoaded(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Plan> plans)?  plansLoaded,TResult Function( Plan plan)?  planLoaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _PlansLoaded() when plansLoaded != null:
return plansLoaded(_that.plans);case _PlanLoaded() when planLoaded != null:
return planLoaded(_that.plan);case _Error() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Plan> plans)  plansLoaded,required TResult Function( Plan plan)  planLoaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _PlansLoaded():
return plansLoaded(_that.plans);case _PlanLoaded():
return planLoaded(_that.plan);case _Error():
return error(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Plan> plans)?  plansLoaded,TResult? Function( Plan plan)?  planLoaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _PlansLoaded() when plansLoaded != null:
return plansLoaded(_that.plans);case _PlanLoaded() when planLoaded != null:
return planLoaded(_that.plan);case _Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PlanState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PlanState.initial()';
}


}




/// @nodoc


class _Loading implements PlanState {
  const _Loading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PlanState.loading()';
}


}




/// @nodoc


class _PlansLoaded implements PlanState {
  const _PlansLoaded( List<Plan> plans): _plans = plans;
  

 final  List<Plan> _plans;
 List<Plan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}


/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlansLoadedCopyWith<_PlansLoaded> get copyWith => __$PlansLoadedCopyWithImpl<_PlansLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlansLoaded&&const DeepCollectionEquality().equals(other.plans, _plans));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_plans));
}

@override
String toString() {
    return 'PlanState.plansLoaded(plans: $plans)';
}


}

/// @nodoc
abstract mixin class _$PlansLoadedCopyWith<$Res> implements $PlanStateCopyWith<$Res> {
  factory _$PlansLoadedCopyWith(_PlansLoaded value, $Res Function(_PlansLoaded) _then) = __$PlansLoadedCopyWithImpl;
@useResult
$Res call({
 List<Plan> plans
});




}
/// @nodoc
class __$PlansLoadedCopyWithImpl<$Res>
    implements _$PlansLoadedCopyWith<$Res> {
  __$PlansLoadedCopyWithImpl(this._self, this._then);

  final _PlansLoaded _self;
  final $Res Function(_PlansLoaded) _then;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plans = null,}) {
  return _then(_PlansLoaded(
null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<Plan>,
  ));
}


}

/// @nodoc


class _PlanLoaded implements PlanState {
  const _PlanLoaded(this.plan);
  

 final  Plan plan;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanLoadedCopyWith<_PlanLoaded> get copyWith => __$PlanLoadedCopyWithImpl<_PlanLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanLoaded&&(identical(other.plan, plan) || other.plan == plan));
}


@override
int get hashCode {
    return Object.hash(runtimeType,plan);
}

@override
String toString() {
    return 'PlanState.planLoaded(plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$PlanLoadedCopyWith<$Res> implements $PlanStateCopyWith<$Res> {
  factory _$PlanLoadedCopyWith(_PlanLoaded value, $Res Function(_PlanLoaded) _then) = __$PlanLoadedCopyWithImpl;
@useResult
$Res call({
 Plan plan
});


$PlanCopyWith<$Res> get plan;

}
/// @nodoc
class __$PlanLoadedCopyWithImpl<$Res>
    implements _$PlanLoadedCopyWith<$Res> {
  __$PlanLoadedCopyWithImpl(this._self, this._then);

  final _PlanLoaded _self;
  final $Res Function(_PlanLoaded) _then;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plan = null,}) {
  return _then(_PlanLoaded(
null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as Plan,
  ));
}

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCopyWith<$Res> get plan {
  
  return $PlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

/// @nodoc


class _Error implements PlanState {
  const _Error(this.failure);
  

 final  Failure failure;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure);
}

@override
String toString() {
    return 'PlanState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PlanStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Error(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on

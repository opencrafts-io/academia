// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rewards_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RewardsOverview {

 RewardAccount get account; List<EarnableActivity> get activities; List<UserStreak> get streaks; List<RewardMilestone> get milestones; List<ActivityHistory> get history;
/// Create a copy of RewardsOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardsOverviewCopyWith<RewardsOverview> get copyWith => _$RewardsOverviewCopyWithImpl<RewardsOverview>(this as RewardsOverview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RewardsOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardsOverview&&(identical(other.account, _this.account) || other.account == _this.account)&&const DeepCollectionEquality().equals(other.activities, _this.activities)&&const DeepCollectionEquality().equals(other.streaks, _this.streaks)&&const DeepCollectionEquality().equals(other.milestones, _this.milestones)&&const DeepCollectionEquality().equals(other.history, _this.history));
}


@override
int get hashCode {
  final _this = this as RewardsOverview;
  return Object.hash(runtimeType,_this.account,const DeepCollectionEquality().hash(_this.activities),const DeepCollectionEquality().hash(_this.streaks),const DeepCollectionEquality().hash(_this.milestones),const DeepCollectionEquality().hash(_this.history));
}

@override
String toString() {
  final _this = this as RewardsOverview;
  return 'RewardsOverview(account: ${_this.account}, activities: ${_this.activities}, streaks: ${_this.streaks}, milestones: ${_this.milestones}, history: ${_this.history})';
}


}

/// @nodoc
abstract mixin class $RewardsOverviewCopyWith<$Res>  {
  factory $RewardsOverviewCopyWith(RewardsOverview value, $Res Function(RewardsOverview) _then) = _$RewardsOverviewCopyWithImpl;
@useResult
$Res call({
 RewardAccount account, List<EarnableActivity> activities, List<UserStreak> streaks, List<RewardMilestone> milestones, List<ActivityHistory> history
});


$RewardAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$RewardsOverviewCopyWithImpl<$Res>
    implements $RewardsOverviewCopyWith<$Res> {
  _$RewardsOverviewCopyWithImpl(this._self, this._then);

  final RewardsOverview _self;
  final $Res Function(RewardsOverview) _then;

/// Create a copy of RewardsOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? activities = null,Object? streaks = null,Object? milestones = null,Object? history = null,}) {
  return _then(RewardsOverview(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as RewardAccount,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<EarnableActivity>,streaks: null == streaks ? _self.streaks : streaks // ignore: cast_nullable_to_non_nullable
as List<UserStreak>,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RewardMilestone>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<ActivityHistory>,
  ));
}
/// Create a copy of RewardsOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardAccountCopyWith<$Res> get account {

  return $RewardAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [RewardsOverview].
extension RewardsOverviewPatterns on RewardsOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardsOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardsOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardsOverview value)  $default,){
final _that = this;
switch (_that) {
case _RewardsOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardsOverview value)?  $default,){
final _that = this;
switch (_that) {
case _RewardsOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RewardAccount account,  List<EarnableActivity> activities,  List<UserStreak> streaks,  List<RewardMilestone> milestones,  List<ActivityHistory> history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardsOverview() when $default != null:
return $default(_that.account,_that.activities,_that.streaks,_that.milestones,_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RewardAccount account,  List<EarnableActivity> activities,  List<UserStreak> streaks,  List<RewardMilestone> milestones,  List<ActivityHistory> history)  $default,) {final _that = this;
switch (_that) {
case _RewardsOverview():
return $default(_that.account,_that.activities,_that.streaks,_that.milestones,_that.history);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RewardAccount account,  List<EarnableActivity> activities,  List<UserStreak> streaks,  List<RewardMilestone> milestones,  List<ActivityHistory> history)?  $default,) {final _that = this;
switch (_that) {
case _RewardsOverview() when $default != null:
return $default(_that.account,_that.activities,_that.streaks,_that.milestones,_that.history);case _:
  return null;

}
}

}

/// @nodoc


class _RewardsOverview implements RewardsOverview {
  const _RewardsOverview({required this.account, required  List<EarnableActivity> activities, required  List<UserStreak> streaks, required  List<RewardMilestone> milestones, required  List<ActivityHistory> history}): _activities = activities,_streaks = streaks,_milestones = milestones,_history = history;


@override final  RewardAccount account;
 final  List<EarnableActivity> _activities;
@override List<EarnableActivity> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

 final  List<UserStreak> _streaks;
@override List<UserStreak> get streaks {
  if (_streaks is EqualUnmodifiableListView) return _streaks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_streaks);
}

 final  List<RewardMilestone> _milestones;
@override List<RewardMilestone> get milestones {
  if (_milestones is EqualUnmodifiableListView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestones);
}

 final  List<ActivityHistory> _history;
@override List<ActivityHistory> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}


/// Create a copy of RewardsOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardsOverviewCopyWith<_RewardsOverview> get copyWith => __$RewardsOverviewCopyWithImpl<_RewardsOverview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardsOverview&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.activities, _activities)&&const DeepCollectionEquality().equals(other.streaks, _streaks)&&const DeepCollectionEquality().equals(other.milestones, _milestones)&&const DeepCollectionEquality().equals(other.history, _history));
}


@override
int get hashCode {
    return Object.hash(runtimeType,account,const DeepCollectionEquality().hash(_activities),const DeepCollectionEquality().hash(_streaks),const DeepCollectionEquality().hash(_milestones),const DeepCollectionEquality().hash(_history));
}

@override
String toString() {
    return 'RewardsOverview(account: $account, activities: $activities, streaks: $streaks, milestones: $milestones, history: $history)';
}


}

/// @nodoc
abstract mixin class _$RewardsOverviewCopyWith<$Res> implements $RewardsOverviewCopyWith<$Res> {
  factory _$RewardsOverviewCopyWith(_RewardsOverview value, $Res Function(_RewardsOverview) _then) = __$RewardsOverviewCopyWithImpl;
@override @useResult
$Res call({
 RewardAccount account, List<EarnableActivity> activities, List<UserStreak> streaks, List<RewardMilestone> milestones, List<ActivityHistory> history
});


@override $RewardAccountCopyWith<$Res> get account;

}
/// @nodoc
class __$RewardsOverviewCopyWithImpl<$Res>
    implements _$RewardsOverviewCopyWith<$Res> {
  __$RewardsOverviewCopyWithImpl(this._self, this._then);

  final _RewardsOverview _self;
  final $Res Function(_RewardsOverview) _then;

/// Create a copy of RewardsOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? activities = null,Object? streaks = null,Object? milestones = null,Object? history = null,}) {
  return _then(_RewardsOverview(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as RewardAccount,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<EarnableActivity>,streaks: null == streaks ? _self._streaks : streaks // ignore: cast_nullable_to_non_nullable
as List<UserStreak>,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<RewardMilestone>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<ActivityHistory>,
  ));
}

/// Create a copy of RewardsOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardAccountCopyWith<$Res> get account {

  return $RewardAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on

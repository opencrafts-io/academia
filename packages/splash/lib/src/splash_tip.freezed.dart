// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_tip.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SplashTip {

 String get id; String get title; String get message; String get actionLabel; SplashTipAction? get action;
/// Create a copy of SplashTip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplashTipCopyWith<SplashTip> get copyWith => _$SplashTipCopyWithImpl<SplashTip>(this as SplashTip, _$identity);

  /// Serializes this SplashTip to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SplashTip;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashTip&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.actionLabel, _this.actionLabel) || other.actionLabel == _this.actionLabel)&&(identical(other.action, _this.action) || other.action == _this.action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SplashTip;
  return Object.hash(runtimeType,_this.id,_this.title,_this.message,_this.actionLabel,_this.action);
}

@override
String toString() {
  final _this = this as SplashTip;
  return 'SplashTip(id: ${_this.id}, title: ${_this.title}, message: ${_this.message}, actionLabel: ${_this.actionLabel}, action: ${_this.action})';
}


}

/// @nodoc
abstract mixin class $SplashTipCopyWith<$Res>  {
  factory $SplashTipCopyWith(SplashTip value, $Res Function(SplashTip) _then) = _$SplashTipCopyWithImpl;
@useResult
$Res call({
 String id, String title, String message, String actionLabel, SplashTipAction? action
});




}
/// @nodoc
class _$SplashTipCopyWithImpl<$Res>
    implements $SplashTipCopyWith<$Res> {
  _$SplashTipCopyWithImpl(this._self, this._then);

  final SplashTip _self;
  final $Res Function(SplashTip) _then;

/// Create a copy of SplashTip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? message = null,Object? actionLabel = null,Object? action = freezed,}) {
  return _then(SplashTip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,actionLabel: null == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String,action: freezed == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SplashTipAction?,
  ));
}

}


/// Adds pattern-matching-related methods to [SplashTip].
extension SplashTipPatterns on SplashTip {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplashTip value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplashTip() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplashTip value)  $default,){
final _that = this;
switch (_that) {
case _SplashTip():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplashTip value)?  $default,){
final _that = this;
switch (_that) {
case _SplashTip() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String message,  String actionLabel,  SplashTipAction? action)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplashTip() when $default != null:
return $default(_that.id,_that.title,_that.message,_that.actionLabel,_that.action);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String message,  String actionLabel,  SplashTipAction? action)  $default,) {final _that = this;
switch (_that) {
case _SplashTip():
return $default(_that.id,_that.title,_that.message,_that.actionLabel,_that.action);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String message,  String actionLabel,  SplashTipAction? action)?  $default,) {final _that = this;
switch (_that) {
case _SplashTip() when $default != null:
return $default(_that.id,_that.title,_that.message,_that.actionLabel,_that.action);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SplashTip extends SplashTip {
  const _SplashTip({required this.id, required this.title, required this.message, this.actionLabel = '', this.action}): super._();
  factory _SplashTip.fromJson(Map<String, dynamic> json) => _$SplashTipFromJson(json);

@override final  String id;
@override final  String title;
@override final  String message;
@override@JsonKey() final  String actionLabel;
@override final  SplashTipAction? action;

/// Create a copy of SplashTip
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplashTipCopyWith<_SplashTip> get copyWith => __$SplashTipCopyWithImpl<_SplashTip>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplashTipToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplashTip&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.actionLabel, actionLabel) || other.actionLabel == actionLabel)&&(identical(other.action, action) || other.action == action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,message,actionLabel,action);
}

@override
String toString() {
    return 'SplashTip(id: $id, title: $title, message: $message, actionLabel: $actionLabel, action: $action)';
}


}

/// @nodoc
abstract mixin class _$SplashTipCopyWith<$Res> implements $SplashTipCopyWith<$Res> {
  factory _$SplashTipCopyWith(_SplashTip value, $Res Function(_SplashTip) _then) = __$SplashTipCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String message, String actionLabel, SplashTipAction? action
});




}
/// @nodoc
class __$SplashTipCopyWithImpl<$Res>
    implements _$SplashTipCopyWith<$Res> {
  __$SplashTipCopyWithImpl(this._self, this._then);

  final _SplashTip _self;
  final $Res Function(_SplashTip) _then;

/// Create a copy of SplashTip
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? message = null,Object? actionLabel = null,Object? action = freezed,}) {
  return _then(_SplashTip(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,actionLabel: null == actionLabel ? _self.actionLabel : actionLabel // ignore: cast_nullable_to_non_nullable
as String,action: freezed == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as SplashTipAction?,
  ));
}


}


/// @nodoc
mixin _$SplashTipConfiguration {

 bool get enabled;@JsonKey(name: 'minimumDisplayMs') int get minimumDisplayMs; List<SplashTip> get tips;
/// Create a copy of SplashTipConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplashTipConfigurationCopyWith<SplashTipConfiguration> get copyWith => _$SplashTipConfigurationCopyWithImpl<SplashTipConfiguration>(this as SplashTipConfiguration, _$identity);

  /// Serializes this SplashTipConfiguration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SplashTipConfiguration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashTipConfiguration&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.minimumDisplayMs, _this.minimumDisplayMs) || other.minimumDisplayMs == _this.minimumDisplayMs)&&const DeepCollectionEquality().equals(other.tips, _this.tips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SplashTipConfiguration;
  return Object.hash(runtimeType,_this.enabled,_this.minimumDisplayMs,const DeepCollectionEquality().hash(_this.tips));
}

@override
String toString() {
  final _this = this as SplashTipConfiguration;
  return 'SplashTipConfiguration(enabled: ${_this.enabled}, minimumDisplayMs: ${_this.minimumDisplayMs}, tips: ${_this.tips})';
}


}

/// @nodoc
abstract mixin class $SplashTipConfigurationCopyWith<$Res>  {
  factory $SplashTipConfigurationCopyWith(SplashTipConfiguration value, $Res Function(SplashTipConfiguration) _then) = _$SplashTipConfigurationCopyWithImpl;
@useResult
$Res call({
 bool enabled,@JsonKey(name: 'minimumDisplayMs') int minimumDisplayMs, List<SplashTip> tips
});




}
/// @nodoc
class _$SplashTipConfigurationCopyWithImpl<$Res>
    implements $SplashTipConfigurationCopyWith<$Res> {
  _$SplashTipConfigurationCopyWithImpl(this._self, this._then);

  final SplashTipConfiguration _self;
  final $Res Function(SplashTipConfiguration) _then;

/// Create a copy of SplashTipConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? minimumDisplayMs = null,Object? tips = null,}) {
  return _then(SplashTipConfiguration(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,minimumDisplayMs: null == minimumDisplayMs ? _self.minimumDisplayMs : minimumDisplayMs // ignore: cast_nullable_to_non_nullable
as int,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<SplashTip>,
  ));
}

}


/// Adds pattern-matching-related methods to [SplashTipConfiguration].
extension SplashTipConfigurationPatterns on SplashTipConfiguration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplashTipConfiguration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplashTipConfiguration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplashTipConfiguration value)  $default,){
final _that = this;
switch (_that) {
case _SplashTipConfiguration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplashTipConfiguration value)?  $default,){
final _that = this;
switch (_that) {
case _SplashTipConfiguration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'minimumDisplayMs')  int minimumDisplayMs,  List<SplashTip> tips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplashTipConfiguration() when $default != null:
return $default(_that.enabled,_that.minimumDisplayMs,_that.tips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled, @JsonKey(name: 'minimumDisplayMs')  int minimumDisplayMs,  List<SplashTip> tips)  $default,) {final _that = this;
switch (_that) {
case _SplashTipConfiguration():
return $default(_that.enabled,_that.minimumDisplayMs,_that.tips);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled, @JsonKey(name: 'minimumDisplayMs')  int minimumDisplayMs,  List<SplashTip> tips)?  $default,) {final _that = this;
switch (_that) {
case _SplashTipConfiguration() when $default != null:
return $default(_that.enabled,_that.minimumDisplayMs,_that.tips);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SplashTipConfiguration extends SplashTipConfiguration {
  const _SplashTipConfiguration({this.enabled = true, @JsonKey(name: 'minimumDisplayMs') this.minimumDisplayMs = 2200,  List<SplashTip> tips = const <SplashTip>[]}): _tips = tips,super._();
  factory _SplashTipConfiguration.fromJson(Map<String, dynamic> json) => _$SplashTipConfigurationFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey(name: 'minimumDisplayMs') final  int minimumDisplayMs;
 final  List<SplashTip> _tips;
@override@JsonKey() List<SplashTip> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}


/// Create a copy of SplashTipConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplashTipConfigurationCopyWith<_SplashTipConfiguration> get copyWith => __$SplashTipConfigurationCopyWithImpl<_SplashTipConfiguration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplashTipConfigurationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplashTipConfiguration&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.minimumDisplayMs, minimumDisplayMs) || other.minimumDisplayMs == minimumDisplayMs)&&const DeepCollectionEquality().equals(other.tips, _tips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enabled,minimumDisplayMs,const DeepCollectionEquality().hash(_tips));
}

@override
String toString() {
    return 'SplashTipConfiguration(enabled: $enabled, minimumDisplayMs: $minimumDisplayMs, tips: $tips)';
}


}

/// @nodoc
abstract mixin class _$SplashTipConfigurationCopyWith<$Res> implements $SplashTipConfigurationCopyWith<$Res> {
  factory _$SplashTipConfigurationCopyWith(_SplashTipConfiguration value, $Res Function(_SplashTipConfiguration) _then) = __$SplashTipConfigurationCopyWithImpl;
@override @useResult
$Res call({
 bool enabled,@JsonKey(name: 'minimumDisplayMs') int minimumDisplayMs, List<SplashTip> tips
});




}
/// @nodoc
class __$SplashTipConfigurationCopyWithImpl<$Res>
    implements _$SplashTipConfigurationCopyWith<$Res> {
  __$SplashTipConfigurationCopyWithImpl(this._self, this._then);

  final _SplashTipConfiguration _self;
  final $Res Function(_SplashTipConfiguration) _then;

/// Create a copy of SplashTipConfiguration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? minimumDisplayMs = null,Object? tips = null,}) {
  return _then(_SplashTipConfiguration(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,minimumDisplayMs: null == minimumDisplayMs ? _self.minimumDisplayMs : minimumDisplayMs // ignore: cast_nullable_to_non_nullable
as int,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<SplashTip>,
  ));
}


}

// dart format on

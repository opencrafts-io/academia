// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scrapping_instruction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
WaitStrategy _$WaitStrategyFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'waitForUrl':
          return _WaitForUrl.fromJson(
            json
          );
                case 'waitForElement':
          return _WaitForElement.fromJson(
            json
          );
                case 'waitForElementDisappear':
          return _WaitForElementDisappear.fromJson(
            json
          );
                case 'waitForNetworkIdle':
          return _WaitForNetworkIdle.fromJson(
            json
          );
                case 'waitForAny':
          return _WaitForAny.fromJson(
            json
          );
                case 'waitForAll':
          return _WaitForAll.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'WaitStrategy',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$WaitStrategy {

 int get timeoutMs;
/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitStrategyCopyWith<WaitStrategy> get copyWith => _$WaitStrategyCopyWithImpl<WaitStrategy>(this as WaitStrategy, _$identity);

  /// Serializes this WaitStrategy to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitStrategy&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeoutMs);

@override
String toString() {
  return 'WaitStrategy(timeoutMs: $timeoutMs)';
}


}

/// @nodoc
abstract mixin class $WaitStrategyCopyWith<$Res>  {
  factory $WaitStrategyCopyWith(WaitStrategy value, $Res Function(WaitStrategy) _then) = _$WaitStrategyCopyWithImpl;
@useResult
$Res call({
 int timeoutMs
});




}
/// @nodoc
class _$WaitStrategyCopyWithImpl<$Res>
    implements $WaitStrategyCopyWith<$Res> {
  _$WaitStrategyCopyWithImpl(this._self, this._then);

  final WaitStrategy _self;
  final $Res Function(WaitStrategy) _then;

/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timeoutMs = null,}) {
  return _then(_self.copyWith(
timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WaitStrategy].
extension WaitStrategyPatterns on WaitStrategy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _WaitForUrl value)?  waitForUrl,TResult Function( _WaitForElement value)?  waitForElement,TResult Function( _WaitForElementDisappear value)?  waitForElementDisappear,TResult Function( _WaitForNetworkIdle value)?  waitForNetworkIdle,TResult Function( _WaitForAny value)?  waitForAny,TResult Function( _WaitForAll value)?  waitForAll,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaitForUrl() when waitForUrl != null:
return waitForUrl(_that);case _WaitForElement() when waitForElement != null:
return waitForElement(_that);case _WaitForElementDisappear() when waitForElementDisappear != null:
return waitForElementDisappear(_that);case _WaitForNetworkIdle() when waitForNetworkIdle != null:
return waitForNetworkIdle(_that);case _WaitForAny() when waitForAny != null:
return waitForAny(_that);case _WaitForAll() when waitForAll != null:
return waitForAll(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _WaitForUrl value)  waitForUrl,required TResult Function( _WaitForElement value)  waitForElement,required TResult Function( _WaitForElementDisappear value)  waitForElementDisappear,required TResult Function( _WaitForNetworkIdle value)  waitForNetworkIdle,required TResult Function( _WaitForAny value)  waitForAny,required TResult Function( _WaitForAll value)  waitForAll,}){
final _that = this;
switch (_that) {
case _WaitForUrl():
return waitForUrl(_that);case _WaitForElement():
return waitForElement(_that);case _WaitForElementDisappear():
return waitForElementDisappear(_that);case _WaitForNetworkIdle():
return waitForNetworkIdle(_that);case _WaitForAny():
return waitForAny(_that);case _WaitForAll():
return waitForAll(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _WaitForUrl value)?  waitForUrl,TResult? Function( _WaitForElement value)?  waitForElement,TResult? Function( _WaitForElementDisappear value)?  waitForElementDisappear,TResult? Function( _WaitForNetworkIdle value)?  waitForNetworkIdle,TResult? Function( _WaitForAny value)?  waitForAny,TResult? Function( _WaitForAll value)?  waitForAll,}){
final _that = this;
switch (_that) {
case _WaitForUrl() when waitForUrl != null:
return waitForUrl(_that);case _WaitForElement() when waitForElement != null:
return waitForElement(_that);case _WaitForElementDisappear() when waitForElementDisappear != null:
return waitForElementDisappear(_that);case _WaitForNetworkIdle() when waitForNetworkIdle != null:
return waitForNetworkIdle(_that);case _WaitForAny() when waitForAny != null:
return waitForAny(_that);case _WaitForAll() when waitForAll != null:
return waitForAll(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String pattern,  int timeoutMs)?  waitForUrl,TResult Function( String selector,  int timeoutMs)?  waitForElement,TResult Function( String selector,  int timeoutMs)?  waitForElementDisappear,TResult Function( int timeoutMs,  int quietDurationMs)?  waitForNetworkIdle,TResult Function( List<WaitStrategy> strategies,  int timeoutMs)?  waitForAny,TResult Function( List<WaitStrategy> strategies,  int timeoutMs)?  waitForAll,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaitForUrl() when waitForUrl != null:
return waitForUrl(_that.pattern,_that.timeoutMs);case _WaitForElement() when waitForElement != null:
return waitForElement(_that.selector,_that.timeoutMs);case _WaitForElementDisappear() when waitForElementDisappear != null:
return waitForElementDisappear(_that.selector,_that.timeoutMs);case _WaitForNetworkIdle() when waitForNetworkIdle != null:
return waitForNetworkIdle(_that.timeoutMs,_that.quietDurationMs);case _WaitForAny() when waitForAny != null:
return waitForAny(_that.strategies,_that.timeoutMs);case _WaitForAll() when waitForAll != null:
return waitForAll(_that.strategies,_that.timeoutMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String pattern,  int timeoutMs)  waitForUrl,required TResult Function( String selector,  int timeoutMs)  waitForElement,required TResult Function( String selector,  int timeoutMs)  waitForElementDisappear,required TResult Function( int timeoutMs,  int quietDurationMs)  waitForNetworkIdle,required TResult Function( List<WaitStrategy> strategies,  int timeoutMs)  waitForAny,required TResult Function( List<WaitStrategy> strategies,  int timeoutMs)  waitForAll,}) {final _that = this;
switch (_that) {
case _WaitForUrl():
return waitForUrl(_that.pattern,_that.timeoutMs);case _WaitForElement():
return waitForElement(_that.selector,_that.timeoutMs);case _WaitForElementDisappear():
return waitForElementDisappear(_that.selector,_that.timeoutMs);case _WaitForNetworkIdle():
return waitForNetworkIdle(_that.timeoutMs,_that.quietDurationMs);case _WaitForAny():
return waitForAny(_that.strategies,_that.timeoutMs);case _WaitForAll():
return waitForAll(_that.strategies,_that.timeoutMs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String pattern,  int timeoutMs)?  waitForUrl,TResult? Function( String selector,  int timeoutMs)?  waitForElement,TResult? Function( String selector,  int timeoutMs)?  waitForElementDisappear,TResult? Function( int timeoutMs,  int quietDurationMs)?  waitForNetworkIdle,TResult? Function( List<WaitStrategy> strategies,  int timeoutMs)?  waitForAny,TResult? Function( List<WaitStrategy> strategies,  int timeoutMs)?  waitForAll,}) {final _that = this;
switch (_that) {
case _WaitForUrl() when waitForUrl != null:
return waitForUrl(_that.pattern,_that.timeoutMs);case _WaitForElement() when waitForElement != null:
return waitForElement(_that.selector,_that.timeoutMs);case _WaitForElementDisappear() when waitForElementDisappear != null:
return waitForElementDisappear(_that.selector,_that.timeoutMs);case _WaitForNetworkIdle() when waitForNetworkIdle != null:
return waitForNetworkIdle(_that.timeoutMs,_that.quietDurationMs);case _WaitForAny() when waitForAny != null:
return waitForAny(_that.strategies,_that.timeoutMs);case _WaitForAll() when waitForAll != null:
return waitForAll(_that.strategies,_that.timeoutMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaitForUrl extends WaitStrategy {
  const _WaitForUrl({required this.pattern, this.timeoutMs = 30000, final  String? $type}): $type = $type ?? 'waitForUrl',super._();
  factory _WaitForUrl.fromJson(Map<String, dynamic> json) => _$WaitForUrlFromJson(json);

 final  String pattern;
@override@JsonKey() final  int timeoutMs;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitForUrlCopyWith<_WaitForUrl> get copyWith => __$WaitForUrlCopyWithImpl<_WaitForUrl>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitForUrlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitForUrl&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,timeoutMs);

@override
String toString() {
  return 'WaitStrategy.waitForUrl(pattern: $pattern, timeoutMs: $timeoutMs)';
}


}

/// @nodoc
abstract mixin class _$WaitForUrlCopyWith<$Res> implements $WaitStrategyCopyWith<$Res> {
  factory _$WaitForUrlCopyWith(_WaitForUrl value, $Res Function(_WaitForUrl) _then) = __$WaitForUrlCopyWithImpl;
@override @useResult
$Res call({
 String pattern, int timeoutMs
});




}
/// @nodoc
class __$WaitForUrlCopyWithImpl<$Res>
    implements _$WaitForUrlCopyWith<$Res> {
  __$WaitForUrlCopyWithImpl(this._self, this._then);

  final _WaitForUrl _self;
  final $Res Function(_WaitForUrl) _then;

/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pattern = null,Object? timeoutMs = null,}) {
  return _then(_WaitForUrl(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _WaitForElement extends WaitStrategy {
  const _WaitForElement({required this.selector, this.timeoutMs = 30000, final  String? $type}): $type = $type ?? 'waitForElement',super._();
  factory _WaitForElement.fromJson(Map<String, dynamic> json) => _$WaitForElementFromJson(json);

 final  String selector;
@override@JsonKey() final  int timeoutMs;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitForElementCopyWith<_WaitForElement> get copyWith => __$WaitForElementCopyWithImpl<_WaitForElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitForElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitForElement&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,timeoutMs);

@override
String toString() {
  return 'WaitStrategy.waitForElement(selector: $selector, timeoutMs: $timeoutMs)';
}


}

/// @nodoc
abstract mixin class _$WaitForElementCopyWith<$Res> implements $WaitStrategyCopyWith<$Res> {
  factory _$WaitForElementCopyWith(_WaitForElement value, $Res Function(_WaitForElement) _then) = __$WaitForElementCopyWithImpl;
@override @useResult
$Res call({
 String selector, int timeoutMs
});




}
/// @nodoc
class __$WaitForElementCopyWithImpl<$Res>
    implements _$WaitForElementCopyWith<$Res> {
  __$WaitForElementCopyWithImpl(this._self, this._then);

  final _WaitForElement _self;
  final $Res Function(_WaitForElement) _then;

/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selector = null,Object? timeoutMs = null,}) {
  return _then(_WaitForElement(
selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _WaitForElementDisappear extends WaitStrategy {
  const _WaitForElementDisappear({required this.selector, this.timeoutMs = 30000, final  String? $type}): $type = $type ?? 'waitForElementDisappear',super._();
  factory _WaitForElementDisappear.fromJson(Map<String, dynamic> json) => _$WaitForElementDisappearFromJson(json);

 final  String selector;
@override@JsonKey() final  int timeoutMs;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitForElementDisappearCopyWith<_WaitForElementDisappear> get copyWith => __$WaitForElementDisappearCopyWithImpl<_WaitForElementDisappear>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitForElementDisappearToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitForElementDisappear&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,timeoutMs);

@override
String toString() {
  return 'WaitStrategy.waitForElementDisappear(selector: $selector, timeoutMs: $timeoutMs)';
}


}

/// @nodoc
abstract mixin class _$WaitForElementDisappearCopyWith<$Res> implements $WaitStrategyCopyWith<$Res> {
  factory _$WaitForElementDisappearCopyWith(_WaitForElementDisappear value, $Res Function(_WaitForElementDisappear) _then) = __$WaitForElementDisappearCopyWithImpl;
@override @useResult
$Res call({
 String selector, int timeoutMs
});




}
/// @nodoc
class __$WaitForElementDisappearCopyWithImpl<$Res>
    implements _$WaitForElementDisappearCopyWith<$Res> {
  __$WaitForElementDisappearCopyWithImpl(this._self, this._then);

  final _WaitForElementDisappear _self;
  final $Res Function(_WaitForElementDisappear) _then;

/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selector = null,Object? timeoutMs = null,}) {
  return _then(_WaitForElementDisappear(
selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _WaitForNetworkIdle extends WaitStrategy {
  const _WaitForNetworkIdle({this.timeoutMs = 30000, this.quietDurationMs = 500, final  String? $type}): $type = $type ?? 'waitForNetworkIdle',super._();
  factory _WaitForNetworkIdle.fromJson(Map<String, dynamic> json) => _$WaitForNetworkIdleFromJson(json);

@override@JsonKey() final  int timeoutMs;
@JsonKey() final  int quietDurationMs;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitForNetworkIdleCopyWith<_WaitForNetworkIdle> get copyWith => __$WaitForNetworkIdleCopyWithImpl<_WaitForNetworkIdle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitForNetworkIdleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitForNetworkIdle&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.quietDurationMs, quietDurationMs) || other.quietDurationMs == quietDurationMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeoutMs,quietDurationMs);

@override
String toString() {
  return 'WaitStrategy.waitForNetworkIdle(timeoutMs: $timeoutMs, quietDurationMs: $quietDurationMs)';
}


}

/// @nodoc
abstract mixin class _$WaitForNetworkIdleCopyWith<$Res> implements $WaitStrategyCopyWith<$Res> {
  factory _$WaitForNetworkIdleCopyWith(_WaitForNetworkIdle value, $Res Function(_WaitForNetworkIdle) _then) = __$WaitForNetworkIdleCopyWithImpl;
@override @useResult
$Res call({
 int timeoutMs, int quietDurationMs
});




}
/// @nodoc
class __$WaitForNetworkIdleCopyWithImpl<$Res>
    implements _$WaitForNetworkIdleCopyWith<$Res> {
  __$WaitForNetworkIdleCopyWithImpl(this._self, this._then);

  final _WaitForNetworkIdle _self;
  final $Res Function(_WaitForNetworkIdle) _then;

/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timeoutMs = null,Object? quietDurationMs = null,}) {
  return _then(_WaitForNetworkIdle(
timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,quietDurationMs: null == quietDurationMs ? _self.quietDurationMs : quietDurationMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _WaitForAny extends WaitStrategy {
  const _WaitForAny({required final  List<WaitStrategy> strategies, this.timeoutMs = 30000, final  String? $type}): _strategies = strategies,$type = $type ?? 'waitForAny',super._();
  factory _WaitForAny.fromJson(Map<String, dynamic> json) => _$WaitForAnyFromJson(json);

 final  List<WaitStrategy> _strategies;
 List<WaitStrategy> get strategies {
  if (_strategies is EqualUnmodifiableListView) return _strategies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strategies);
}

@override@JsonKey() final  int timeoutMs;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitForAnyCopyWith<_WaitForAny> get copyWith => __$WaitForAnyCopyWithImpl<_WaitForAny>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitForAnyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitForAny&&const DeepCollectionEquality().equals(other._strategies, _strategies)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_strategies),timeoutMs);

@override
String toString() {
  return 'WaitStrategy.waitForAny(strategies: $strategies, timeoutMs: $timeoutMs)';
}


}

/// @nodoc
abstract mixin class _$WaitForAnyCopyWith<$Res> implements $WaitStrategyCopyWith<$Res> {
  factory _$WaitForAnyCopyWith(_WaitForAny value, $Res Function(_WaitForAny) _then) = __$WaitForAnyCopyWithImpl;
@override @useResult
$Res call({
 List<WaitStrategy> strategies, int timeoutMs
});




}
/// @nodoc
class __$WaitForAnyCopyWithImpl<$Res>
    implements _$WaitForAnyCopyWith<$Res> {
  __$WaitForAnyCopyWithImpl(this._self, this._then);

  final _WaitForAny _self;
  final $Res Function(_WaitForAny) _then;

/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strategies = null,Object? timeoutMs = null,}) {
  return _then(_WaitForAny(
strategies: null == strategies ? _self._strategies : strategies // ignore: cast_nullable_to_non_nullable
as List<WaitStrategy>,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class _WaitForAll extends WaitStrategy {
  const _WaitForAll({required final  List<WaitStrategy> strategies, this.timeoutMs = 30000, final  String? $type}): _strategies = strategies,$type = $type ?? 'waitForAll',super._();
  factory _WaitForAll.fromJson(Map<String, dynamic> json) => _$WaitForAllFromJson(json);

 final  List<WaitStrategy> _strategies;
 List<WaitStrategy> get strategies {
  if (_strategies is EqualUnmodifiableListView) return _strategies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strategies);
}

@override@JsonKey() final  int timeoutMs;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitForAllCopyWith<_WaitForAll> get copyWith => __$WaitForAllCopyWithImpl<_WaitForAll>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitForAllToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitForAll&&const DeepCollectionEquality().equals(other._strategies, _strategies)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_strategies),timeoutMs);

@override
String toString() {
  return 'WaitStrategy.waitForAll(strategies: $strategies, timeoutMs: $timeoutMs)';
}


}

/// @nodoc
abstract mixin class _$WaitForAllCopyWith<$Res> implements $WaitStrategyCopyWith<$Res> {
  factory _$WaitForAllCopyWith(_WaitForAll value, $Res Function(_WaitForAll) _then) = __$WaitForAllCopyWithImpl;
@override @useResult
$Res call({
 List<WaitStrategy> strategies, int timeoutMs
});




}
/// @nodoc
class __$WaitForAllCopyWithImpl<$Res>
    implements _$WaitForAllCopyWith<$Res> {
  __$WaitForAllCopyWithImpl(this._self, this._then);

  final _WaitForAll _self;
  final $Res Function(_WaitForAll) _then;

/// Create a copy of WaitStrategy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strategies = null,Object? timeoutMs = null,}) {
  return _then(_WaitForAll(
strategies: null == strategies ? _self._strategies : strategies // ignore: cast_nullable_to_non_nullable
as List<WaitStrategy>,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ScrapingInstruction {

/// The action type to perform (e.g., 'extract', 'click', 'fill-form').
 String get type;/// Determines how the engine handles errors for this specific step.
/// Defaults to [FaultStrategy.abort].
 FaultStrategy get faultStrategy;/// Number of times to re-attempt the task if it fails.
/// Only applicable if [faultStrategy] is set to [FaultStrategy.retry].
 int get maxRetries;/// The duration to wait between retry attempts.
 Duration get retryDelay;/// A CSS selector used to target a DOM element.
 String? get selector;/// An XPath expression used to target a DOM element.
/// If both [selector] and [xpath] are provided, [selector] usually takes priority.
 String? get xpath;/// The HTML attribute to target (e.g., 'href', 'src', 'value').
 String? get attribute;/// The literal value to be used (e.g., text to input into a form).
 String? get value;/// A fixed delay in milliseconds to wait before executing this instruction.
 int? get waitMilliseconds;/// A complex waiting condition (e.g., wait for network idle) to satisfy
/// before or during execution.
 WaitStrategy? get waitStrategy;/// Custom JavaScript code to be injected and executed within the page context.
 String? get jsCode;/// The key name used to store the result in the final output map.
 String? get outputKey;/// Internal key used to reference values across different instructions.
 String? get valueKey;/// The keyboard/input type for form fields (e.g., 'text', 'password', 'number').
 String? get inputType;/// A human-readable label for the input field, useful for logging or UI mirroring.
 String? get inputLabel;/// If true, the engine will trigger the [waitStrategy] *after* the action
/// is performed (e.g., click a button then wait for a new element).
 bool get waitAfterExecution;
/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrapingInstructionCopyWith<ScrapingInstruction> get copyWith => _$ScrapingInstructionCopyWithImpl<ScrapingInstruction>(this as ScrapingInstruction, _$identity);

  /// Serializes this ScrapingInstruction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrapingInstruction&&(identical(other.type, type) || other.type == type)&&(identical(other.faultStrategy, faultStrategy) || other.faultStrategy == faultStrategy)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.xpath, xpath) || other.xpath == xpath)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.value, value) || other.value == value)&&(identical(other.waitMilliseconds, waitMilliseconds) || other.waitMilliseconds == waitMilliseconds)&&(identical(other.waitStrategy, waitStrategy) || other.waitStrategy == waitStrategy)&&(identical(other.jsCode, jsCode) || other.jsCode == jsCode)&&(identical(other.outputKey, outputKey) || other.outputKey == outputKey)&&(identical(other.valueKey, valueKey) || other.valueKey == valueKey)&&(identical(other.inputType, inputType) || other.inputType == inputType)&&(identical(other.inputLabel, inputLabel) || other.inputLabel == inputLabel)&&(identical(other.waitAfterExecution, waitAfterExecution) || other.waitAfterExecution == waitAfterExecution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,faultStrategy,maxRetries,retryDelay,selector,xpath,attribute,value,waitMilliseconds,waitStrategy,jsCode,outputKey,valueKey,inputType,inputLabel,waitAfterExecution);

@override
String toString() {
  return 'ScrapingInstruction(type: $type, faultStrategy: $faultStrategy, maxRetries: $maxRetries, retryDelay: $retryDelay, selector: $selector, xpath: $xpath, attribute: $attribute, value: $value, waitMilliseconds: $waitMilliseconds, waitStrategy: $waitStrategy, jsCode: $jsCode, outputKey: $outputKey, valueKey: $valueKey, inputType: $inputType, inputLabel: $inputLabel, waitAfterExecution: $waitAfterExecution)';
}


}

/// @nodoc
abstract mixin class $ScrapingInstructionCopyWith<$Res>  {
  factory $ScrapingInstructionCopyWith(ScrapingInstruction value, $Res Function(ScrapingInstruction) _then) = _$ScrapingInstructionCopyWithImpl;
@useResult
$Res call({
 String type, FaultStrategy faultStrategy, int maxRetries, Duration retryDelay, String? selector, String? xpath, String? attribute, String? value, int? waitMilliseconds, WaitStrategy? waitStrategy, String? jsCode, String? outputKey, String? valueKey, String? inputType, String? inputLabel, bool waitAfterExecution
});


$WaitStrategyCopyWith<$Res>? get waitStrategy;

}
/// @nodoc
class _$ScrapingInstructionCopyWithImpl<$Res>
    implements $ScrapingInstructionCopyWith<$Res> {
  _$ScrapingInstructionCopyWithImpl(this._self, this._then);

  final ScrapingInstruction _self;
  final $Res Function(ScrapingInstruction) _then;

/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? faultStrategy = null,Object? maxRetries = null,Object? retryDelay = null,Object? selector = freezed,Object? xpath = freezed,Object? attribute = freezed,Object? value = freezed,Object? waitMilliseconds = freezed,Object? waitStrategy = freezed,Object? jsCode = freezed,Object? outputKey = freezed,Object? valueKey = freezed,Object? inputType = freezed,Object? inputLabel = freezed,Object? waitAfterExecution = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,faultStrategy: null == faultStrategy ? _self.faultStrategy : faultStrategy // ignore: cast_nullable_to_non_nullable
as FaultStrategy,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,retryDelay: null == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration,selector: freezed == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String?,xpath: freezed == xpath ? _self.xpath : xpath // ignore: cast_nullable_to_non_nullable
as String?,attribute: freezed == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,waitMilliseconds: freezed == waitMilliseconds ? _self.waitMilliseconds : waitMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,waitStrategy: freezed == waitStrategy ? _self.waitStrategy : waitStrategy // ignore: cast_nullable_to_non_nullable
as WaitStrategy?,jsCode: freezed == jsCode ? _self.jsCode : jsCode // ignore: cast_nullable_to_non_nullable
as String?,outputKey: freezed == outputKey ? _self.outputKey : outputKey // ignore: cast_nullable_to_non_nullable
as String?,valueKey: freezed == valueKey ? _self.valueKey : valueKey // ignore: cast_nullable_to_non_nullable
as String?,inputType: freezed == inputType ? _self.inputType : inputType // ignore: cast_nullable_to_non_nullable
as String?,inputLabel: freezed == inputLabel ? _self.inputLabel : inputLabel // ignore: cast_nullable_to_non_nullable
as String?,waitAfterExecution: null == waitAfterExecution ? _self.waitAfterExecution : waitAfterExecution // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitStrategyCopyWith<$Res>? get waitStrategy {
    if (_self.waitStrategy == null) {
    return null;
  }

  return $WaitStrategyCopyWith<$Res>(_self.waitStrategy!, (value) {
    return _then(_self.copyWith(waitStrategy: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScrapingInstruction].
extension ScrapingInstructionPatterns on ScrapingInstruction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScrapingInstruction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScrapingInstruction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScrapingInstruction value)  $default,){
final _that = this;
switch (_that) {
case _ScrapingInstruction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScrapingInstruction value)?  $default,){
final _that = this;
switch (_that) {
case _ScrapingInstruction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  FaultStrategy faultStrategy,  int maxRetries,  Duration retryDelay,  String? selector,  String? xpath,  String? attribute,  String? value,  int? waitMilliseconds,  WaitStrategy? waitStrategy,  String? jsCode,  String? outputKey,  String? valueKey,  String? inputType,  String? inputLabel,  bool waitAfterExecution)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScrapingInstruction() when $default != null:
return $default(_that.type,_that.faultStrategy,_that.maxRetries,_that.retryDelay,_that.selector,_that.xpath,_that.attribute,_that.value,_that.waitMilliseconds,_that.waitStrategy,_that.jsCode,_that.outputKey,_that.valueKey,_that.inputType,_that.inputLabel,_that.waitAfterExecution);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  FaultStrategy faultStrategy,  int maxRetries,  Duration retryDelay,  String? selector,  String? xpath,  String? attribute,  String? value,  int? waitMilliseconds,  WaitStrategy? waitStrategy,  String? jsCode,  String? outputKey,  String? valueKey,  String? inputType,  String? inputLabel,  bool waitAfterExecution)  $default,) {final _that = this;
switch (_that) {
case _ScrapingInstruction():
return $default(_that.type,_that.faultStrategy,_that.maxRetries,_that.retryDelay,_that.selector,_that.xpath,_that.attribute,_that.value,_that.waitMilliseconds,_that.waitStrategy,_that.jsCode,_that.outputKey,_that.valueKey,_that.inputType,_that.inputLabel,_that.waitAfterExecution);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  FaultStrategy faultStrategy,  int maxRetries,  Duration retryDelay,  String? selector,  String? xpath,  String? attribute,  String? value,  int? waitMilliseconds,  WaitStrategy? waitStrategy,  String? jsCode,  String? outputKey,  String? valueKey,  String? inputType,  String? inputLabel,  bool waitAfterExecution)?  $default,) {final _that = this;
switch (_that) {
case _ScrapingInstruction() when $default != null:
return $default(_that.type,_that.faultStrategy,_that.maxRetries,_that.retryDelay,_that.selector,_that.xpath,_that.attribute,_that.value,_that.waitMilliseconds,_that.waitStrategy,_that.jsCode,_that.outputKey,_that.valueKey,_that.inputType,_that.inputLabel,_that.waitAfterExecution);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScrapingInstruction extends ScrapingInstruction {
  const _ScrapingInstruction({required this.type, this.faultStrategy = FaultStrategy.abort, this.maxRetries = 0, this.retryDelay = const Duration(seconds: 1), this.selector, this.xpath, this.attribute, this.value, this.waitMilliseconds, this.waitStrategy, this.jsCode, this.outputKey, this.valueKey, this.inputType, this.inputLabel, this.waitAfterExecution = false}): super._();
  factory _ScrapingInstruction.fromJson(Map<String, dynamic> json) => _$ScrapingInstructionFromJson(json);

/// The action type to perform (e.g., 'extract', 'click', 'fill-form').
@override final  String type;
/// Determines how the engine handles errors for this specific step.
/// Defaults to [FaultStrategy.abort].
@override@JsonKey() final  FaultStrategy faultStrategy;
/// Number of times to re-attempt the task if it fails.
/// Only applicable if [faultStrategy] is set to [FaultStrategy.retry].
@override@JsonKey() final  int maxRetries;
/// The duration to wait between retry attempts.
@override@JsonKey() final  Duration retryDelay;
/// A CSS selector used to target a DOM element.
@override final  String? selector;
/// An XPath expression used to target a DOM element.
/// If both [selector] and [xpath] are provided, [selector] usually takes priority.
@override final  String? xpath;
/// The HTML attribute to target (e.g., 'href', 'src', 'value').
@override final  String? attribute;
/// The literal value to be used (e.g., text to input into a form).
@override final  String? value;
/// A fixed delay in milliseconds to wait before executing this instruction.
@override final  int? waitMilliseconds;
/// A complex waiting condition (e.g., wait for network idle) to satisfy
/// before or during execution.
@override final  WaitStrategy? waitStrategy;
/// Custom JavaScript code to be injected and executed within the page context.
@override final  String? jsCode;
/// The key name used to store the result in the final output map.
@override final  String? outputKey;
/// Internal key used to reference values across different instructions.
@override final  String? valueKey;
/// The keyboard/input type for form fields (e.g., 'text', 'password', 'number').
@override final  String? inputType;
/// A human-readable label for the input field, useful for logging or UI mirroring.
@override final  String? inputLabel;
/// If true, the engine will trigger the [waitStrategy] *after* the action
/// is performed (e.g., click a button then wait for a new element).
@override@JsonKey() final  bool waitAfterExecution;

/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrapingInstructionCopyWith<_ScrapingInstruction> get copyWith => __$ScrapingInstructionCopyWithImpl<_ScrapingInstruction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScrapingInstructionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrapingInstruction&&(identical(other.type, type) || other.type == type)&&(identical(other.faultStrategy, faultStrategy) || other.faultStrategy == faultStrategy)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries)&&(identical(other.retryDelay, retryDelay) || other.retryDelay == retryDelay)&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.xpath, xpath) || other.xpath == xpath)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.value, value) || other.value == value)&&(identical(other.waitMilliseconds, waitMilliseconds) || other.waitMilliseconds == waitMilliseconds)&&(identical(other.waitStrategy, waitStrategy) || other.waitStrategy == waitStrategy)&&(identical(other.jsCode, jsCode) || other.jsCode == jsCode)&&(identical(other.outputKey, outputKey) || other.outputKey == outputKey)&&(identical(other.valueKey, valueKey) || other.valueKey == valueKey)&&(identical(other.inputType, inputType) || other.inputType == inputType)&&(identical(other.inputLabel, inputLabel) || other.inputLabel == inputLabel)&&(identical(other.waitAfterExecution, waitAfterExecution) || other.waitAfterExecution == waitAfterExecution));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,faultStrategy,maxRetries,retryDelay,selector,xpath,attribute,value,waitMilliseconds,waitStrategy,jsCode,outputKey,valueKey,inputType,inputLabel,waitAfterExecution);

@override
String toString() {
  return 'ScrapingInstruction(type: $type, faultStrategy: $faultStrategy, maxRetries: $maxRetries, retryDelay: $retryDelay, selector: $selector, xpath: $xpath, attribute: $attribute, value: $value, waitMilliseconds: $waitMilliseconds, waitStrategy: $waitStrategy, jsCode: $jsCode, outputKey: $outputKey, valueKey: $valueKey, inputType: $inputType, inputLabel: $inputLabel, waitAfterExecution: $waitAfterExecution)';
}


}

/// @nodoc
abstract mixin class _$ScrapingInstructionCopyWith<$Res> implements $ScrapingInstructionCopyWith<$Res> {
  factory _$ScrapingInstructionCopyWith(_ScrapingInstruction value, $Res Function(_ScrapingInstruction) _then) = __$ScrapingInstructionCopyWithImpl;
@override @useResult
$Res call({
 String type, FaultStrategy faultStrategy, int maxRetries, Duration retryDelay, String? selector, String? xpath, String? attribute, String? value, int? waitMilliseconds, WaitStrategy? waitStrategy, String? jsCode, String? outputKey, String? valueKey, String? inputType, String? inputLabel, bool waitAfterExecution
});


@override $WaitStrategyCopyWith<$Res>? get waitStrategy;

}
/// @nodoc
class __$ScrapingInstructionCopyWithImpl<$Res>
    implements _$ScrapingInstructionCopyWith<$Res> {
  __$ScrapingInstructionCopyWithImpl(this._self, this._then);

  final _ScrapingInstruction _self;
  final $Res Function(_ScrapingInstruction) _then;

/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? faultStrategy = null,Object? maxRetries = null,Object? retryDelay = null,Object? selector = freezed,Object? xpath = freezed,Object? attribute = freezed,Object? value = freezed,Object? waitMilliseconds = freezed,Object? waitStrategy = freezed,Object? jsCode = freezed,Object? outputKey = freezed,Object? valueKey = freezed,Object? inputType = freezed,Object? inputLabel = freezed,Object? waitAfterExecution = null,}) {
  return _then(_ScrapingInstruction(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,faultStrategy: null == faultStrategy ? _self.faultStrategy : faultStrategy // ignore: cast_nullable_to_non_nullable
as FaultStrategy,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,retryDelay: null == retryDelay ? _self.retryDelay : retryDelay // ignore: cast_nullable_to_non_nullable
as Duration,selector: freezed == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String?,xpath: freezed == xpath ? _self.xpath : xpath // ignore: cast_nullable_to_non_nullable
as String?,attribute: freezed == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,waitMilliseconds: freezed == waitMilliseconds ? _self.waitMilliseconds : waitMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,waitStrategy: freezed == waitStrategy ? _self.waitStrategy : waitStrategy // ignore: cast_nullable_to_non_nullable
as WaitStrategy?,jsCode: freezed == jsCode ? _self.jsCode : jsCode // ignore: cast_nullable_to_non_nullable
as String?,outputKey: freezed == outputKey ? _self.outputKey : outputKey // ignore: cast_nullable_to_non_nullable
as String?,valueKey: freezed == valueKey ? _self.valueKey : valueKey // ignore: cast_nullable_to_non_nullable
as String?,inputType: freezed == inputType ? _self.inputType : inputType // ignore: cast_nullable_to_non_nullable
as String?,inputLabel: freezed == inputLabel ? _self.inputLabel : inputLabel // ignore: cast_nullable_to_non_nullable
as String?,waitAfterExecution: null == waitAfterExecution ? _self.waitAfterExecution : waitAfterExecution // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WaitStrategyCopyWith<$Res>? get waitStrategy {
    if (_self.waitStrategy == null) {
    return null;
  }

  return $WaitStrategyCopyWith<$Res>(_self.waitStrategy!, (value) {
    return _then(_self.copyWith(waitStrategy: value));
  });
}
}

// dart format on

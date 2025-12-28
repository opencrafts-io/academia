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

/// @nodoc
mixin _$ScrapingInstruction {

/// 'extract', 'click', 'fillForm', 'wait', 'executeJs', 'screenshot'
 String get type;/// CSS selector to be used
 String? get selector;/// The xpath of the element - used instead of the css selector
 String? get xpath; String? get attribute; String? get value; int? get waitMilliseconds; String? get jsCode; String? get outputKey;/// For conditional/nested operations
 List<ScrapingInstruction>? get steps;
/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrapingInstructionCopyWith<ScrapingInstruction> get copyWith => _$ScrapingInstructionCopyWithImpl<ScrapingInstruction>(this as ScrapingInstruction, _$identity);

  /// Serializes this ScrapingInstruction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrapingInstruction&&(identical(other.type, type) || other.type == type)&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.xpath, xpath) || other.xpath == xpath)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.value, value) || other.value == value)&&(identical(other.waitMilliseconds, waitMilliseconds) || other.waitMilliseconds == waitMilliseconds)&&(identical(other.jsCode, jsCode) || other.jsCode == jsCode)&&(identical(other.outputKey, outputKey) || other.outputKey == outputKey)&&const DeepCollectionEquality().equals(other.steps, steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,selector,xpath,attribute,value,waitMilliseconds,jsCode,outputKey,const DeepCollectionEquality().hash(steps));

@override
String toString() {
  return 'ScrapingInstruction(type: $type, selector: $selector, xpath: $xpath, attribute: $attribute, value: $value, waitMilliseconds: $waitMilliseconds, jsCode: $jsCode, outputKey: $outputKey, steps: $steps)';
}


}

/// @nodoc
abstract mixin class $ScrapingInstructionCopyWith<$Res>  {
  factory $ScrapingInstructionCopyWith(ScrapingInstruction value, $Res Function(ScrapingInstruction) _then) = _$ScrapingInstructionCopyWithImpl;
@useResult
$Res call({
 String type, String? selector, String? xpath, String? attribute, String? value, int? waitMilliseconds, String? jsCode, String? outputKey, List<ScrapingInstruction>? steps
});




}
/// @nodoc
class _$ScrapingInstructionCopyWithImpl<$Res>
    implements $ScrapingInstructionCopyWith<$Res> {
  _$ScrapingInstructionCopyWithImpl(this._self, this._then);

  final ScrapingInstruction _self;
  final $Res Function(ScrapingInstruction) _then;

/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? selector = freezed,Object? xpath = freezed,Object? attribute = freezed,Object? value = freezed,Object? waitMilliseconds = freezed,Object? jsCode = freezed,Object? outputKey = freezed,Object? steps = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,selector: freezed == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String?,xpath: freezed == xpath ? _self.xpath : xpath // ignore: cast_nullable_to_non_nullable
as String?,attribute: freezed == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,waitMilliseconds: freezed == waitMilliseconds ? _self.waitMilliseconds : waitMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,jsCode: freezed == jsCode ? _self.jsCode : jsCode // ignore: cast_nullable_to_non_nullable
as String?,outputKey: freezed == outputKey ? _self.outputKey : outputKey // ignore: cast_nullable_to_non_nullable
as String?,steps: freezed == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<ScrapingInstruction>?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String? selector,  String? xpath,  String? attribute,  String? value,  int? waitMilliseconds,  String? jsCode,  String? outputKey,  List<ScrapingInstruction>? steps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScrapingInstruction() when $default != null:
return $default(_that.type,_that.selector,_that.xpath,_that.attribute,_that.value,_that.waitMilliseconds,_that.jsCode,_that.outputKey,_that.steps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String? selector,  String? xpath,  String? attribute,  String? value,  int? waitMilliseconds,  String? jsCode,  String? outputKey,  List<ScrapingInstruction>? steps)  $default,) {final _that = this;
switch (_that) {
case _ScrapingInstruction():
return $default(_that.type,_that.selector,_that.xpath,_that.attribute,_that.value,_that.waitMilliseconds,_that.jsCode,_that.outputKey,_that.steps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String? selector,  String? xpath,  String? attribute,  String? value,  int? waitMilliseconds,  String? jsCode,  String? outputKey,  List<ScrapingInstruction>? steps)?  $default,) {final _that = this;
switch (_that) {
case _ScrapingInstruction() when $default != null:
return $default(_that.type,_that.selector,_that.xpath,_that.attribute,_that.value,_that.waitMilliseconds,_that.jsCode,_that.outputKey,_that.steps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScrapingInstruction extends ScrapingInstruction {
  const _ScrapingInstruction({required this.type, this.selector, this.xpath, this.attribute, this.value, this.waitMilliseconds, this.jsCode, this.outputKey, final  List<ScrapingInstruction>? steps}): _steps = steps,super._();
  factory _ScrapingInstruction.fromJson(Map<String, dynamic> json) => _$ScrapingInstructionFromJson(json);

/// 'extract', 'click', 'fillForm', 'wait', 'executeJs', 'screenshot'
@override final  String type;
/// CSS selector to be used
@override final  String? selector;
/// The xpath of the element - used instead of the css selector
@override final  String? xpath;
@override final  String? attribute;
@override final  String? value;
@override final  int? waitMilliseconds;
@override final  String? jsCode;
@override final  String? outputKey;
/// For conditional/nested operations
 final  List<ScrapingInstruction>? _steps;
/// For conditional/nested operations
@override List<ScrapingInstruction>? get steps {
  final value = _steps;
  if (value == null) return null;
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrapingInstruction&&(identical(other.type, type) || other.type == type)&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.xpath, xpath) || other.xpath == xpath)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&(identical(other.value, value) || other.value == value)&&(identical(other.waitMilliseconds, waitMilliseconds) || other.waitMilliseconds == waitMilliseconds)&&(identical(other.jsCode, jsCode) || other.jsCode == jsCode)&&(identical(other.outputKey, outputKey) || other.outputKey == outputKey)&&const DeepCollectionEquality().equals(other._steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,selector,xpath,attribute,value,waitMilliseconds,jsCode,outputKey,const DeepCollectionEquality().hash(_steps));

@override
String toString() {
  return 'ScrapingInstruction(type: $type, selector: $selector, xpath: $xpath, attribute: $attribute, value: $value, waitMilliseconds: $waitMilliseconds, jsCode: $jsCode, outputKey: $outputKey, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$ScrapingInstructionCopyWith<$Res> implements $ScrapingInstructionCopyWith<$Res> {
  factory _$ScrapingInstructionCopyWith(_ScrapingInstruction value, $Res Function(_ScrapingInstruction) _then) = __$ScrapingInstructionCopyWithImpl;
@override @useResult
$Res call({
 String type, String? selector, String? xpath, String? attribute, String? value, int? waitMilliseconds, String? jsCode, String? outputKey, List<ScrapingInstruction>? steps
});




}
/// @nodoc
class __$ScrapingInstructionCopyWithImpl<$Res>
    implements _$ScrapingInstructionCopyWith<$Res> {
  __$ScrapingInstructionCopyWithImpl(this._self, this._then);

  final _ScrapingInstruction _self;
  final $Res Function(_ScrapingInstruction) _then;

/// Create a copy of ScrapingInstruction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? selector = freezed,Object? xpath = freezed,Object? attribute = freezed,Object? value = freezed,Object? waitMilliseconds = freezed,Object? jsCode = freezed,Object? outputKey = freezed,Object? steps = freezed,}) {
  return _then(_ScrapingInstruction(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,selector: freezed == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String?,xpath: freezed == xpath ? _self.xpath : xpath // ignore: cast_nullable_to_non_nullable
as String?,attribute: freezed == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,waitMilliseconds: freezed == waitMilliseconds ? _self.waitMilliseconds : waitMilliseconds // ignore: cast_nullable_to_non_nullable
as int?,jsCode: freezed == jsCode ? _self.jsCode : jsCode // ignore: cast_nullable_to_non_nullable
as String?,outputKey: freezed == outputKey ? _self.outputKey : outputKey // ignore: cast_nullable_to_non_nullable
as String?,steps: freezed == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<ScrapingInstruction>?,
  ));
}


}

// dart format on

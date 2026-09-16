// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_api_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InstitutionApiDto {

@JsonKey(name: 'institution_id') int get institutionId; String get name;@JsonKey(name: 'web_pages') List<String>? get webPages; List<String>? get domains;@JsonKey(name: 'alpha_two_code') String? get alphaTwoCode; String? get country;@JsonKey(name: 'state_province') String? get stateProvince;
/// Create a copy of InstitutionApiDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionApiDtoCopyWith<InstitutionApiDto> get copyWith => _$InstitutionApiDtoCopyWithImpl<InstitutionApiDto>(this as InstitutionApiDto, _$identity);

  /// Serializes this InstitutionApiDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionApiDto&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.webPages, webPages)&&const DeepCollectionEquality().equals(other.domains, domains)&&(identical(other.alphaTwoCode, alphaTwoCode) || other.alphaTwoCode == alphaTwoCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.stateProvince, stateProvince) || other.stateProvince == stateProvince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institutionId,name,const DeepCollectionEquality().hash(webPages),const DeepCollectionEquality().hash(domains),alphaTwoCode,country,stateProvince);

@override
String toString() {
  return 'InstitutionApiDto(institutionId: $institutionId, name: $name, webPages: $webPages, domains: $domains, alphaTwoCode: $alphaTwoCode, country: $country, stateProvince: $stateProvince)';
}


}

/// @nodoc
abstract mixin class $InstitutionApiDtoCopyWith<$Res>  {
  factory $InstitutionApiDtoCopyWith(InstitutionApiDto value, $Res Function(InstitutionApiDto) _then) = _$InstitutionApiDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'institution_id') int institutionId, String name,@JsonKey(name: 'web_pages') List<String>? webPages, List<String>? domains,@JsonKey(name: 'alpha_two_code') String? alphaTwoCode, String? country,@JsonKey(name: 'state_province') String? stateProvince
});




}
/// @nodoc
class _$InstitutionApiDtoCopyWithImpl<$Res>
    implements $InstitutionApiDtoCopyWith<$Res> {
  _$InstitutionApiDtoCopyWithImpl(this._self, this._then);

  final InstitutionApiDto _self;
  final $Res Function(InstitutionApiDto) _then;

/// Create a copy of InstitutionApiDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? institutionId = null,Object? name = null,Object? webPages = freezed,Object? domains = freezed,Object? alphaTwoCode = freezed,Object? country = freezed,Object? stateProvince = freezed,}) {
  return _then(_self.copyWith(
institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,webPages: freezed == webPages ? _self.webPages : webPages // ignore: cast_nullable_to_non_nullable
as List<String>?,domains: freezed == domains ? _self.domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>?,alphaTwoCode: freezed == alphaTwoCode ? _self.alphaTwoCode : alphaTwoCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,stateProvince: freezed == stateProvince ? _self.stateProvince : stateProvince // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionApiDto].
extension InstitutionApiDtoPatterns on InstitutionApiDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionApiDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionApiDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionApiDto value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionApiDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionApiDto value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionApiDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'institution_id')  int institutionId,  String name, @JsonKey(name: 'web_pages')  List<String>? webPages,  List<String>? domains, @JsonKey(name: 'alpha_two_code')  String? alphaTwoCode,  String? country, @JsonKey(name: 'state_province')  String? stateProvince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionApiDto() when $default != null:
return $default(_that.institutionId,_that.name,_that.webPages,_that.domains,_that.alphaTwoCode,_that.country,_that.stateProvince);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'institution_id')  int institutionId,  String name, @JsonKey(name: 'web_pages')  List<String>? webPages,  List<String>? domains, @JsonKey(name: 'alpha_two_code')  String? alphaTwoCode,  String? country, @JsonKey(name: 'state_province')  String? stateProvince)  $default,) {final _that = this;
switch (_that) {
case _InstitutionApiDto():
return $default(_that.institutionId,_that.name,_that.webPages,_that.domains,_that.alphaTwoCode,_that.country,_that.stateProvince);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'institution_id')  int institutionId,  String name, @JsonKey(name: 'web_pages')  List<String>? webPages,  List<String>? domains, @JsonKey(name: 'alpha_two_code')  String? alphaTwoCode,  String? country, @JsonKey(name: 'state_province')  String? stateProvince)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionApiDto() when $default != null:
return $default(_that.institutionId,_that.name,_that.webPages,_that.domains,_that.alphaTwoCode,_that.country,_that.stateProvince);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InstitutionApiDto implements InstitutionApiDto {
  const _InstitutionApiDto({@JsonKey(name: 'institution_id') required this.institutionId, required this.name, @JsonKey(name: 'web_pages') final  List<String>? webPages, final  List<String>? domains, @JsonKey(name: 'alpha_two_code') this.alphaTwoCode, this.country, @JsonKey(name: 'state_province') this.stateProvince}): _webPages = webPages,_domains = domains;
  factory _InstitutionApiDto.fromJson(Map<String, dynamic> json) => _$InstitutionApiDtoFromJson(json);

@override@JsonKey(name: 'institution_id') final  int institutionId;
@override final  String name;
 final  List<String>? _webPages;
@override@JsonKey(name: 'web_pages') List<String>? get webPages {
  final value = _webPages;
  if (value == null) return null;
  if (_webPages is EqualUnmodifiableListView) return _webPages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _domains;
@override List<String>? get domains {
  final value = _domains;
  if (value == null) return null;
  if (_domains is EqualUnmodifiableListView) return _domains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'alpha_two_code') final  String? alphaTwoCode;
@override final  String? country;
@override@JsonKey(name: 'state_province') final  String? stateProvince;

/// Create a copy of InstitutionApiDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionApiDtoCopyWith<_InstitutionApiDto> get copyWith => __$InstitutionApiDtoCopyWithImpl<_InstitutionApiDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InstitutionApiDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionApiDto&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._webPages, _webPages)&&const DeepCollectionEquality().equals(other._domains, _domains)&&(identical(other.alphaTwoCode, alphaTwoCode) || other.alphaTwoCode == alphaTwoCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.stateProvince, stateProvince) || other.stateProvince == stateProvince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institutionId,name,const DeepCollectionEquality().hash(_webPages),const DeepCollectionEquality().hash(_domains),alphaTwoCode,country,stateProvince);

@override
String toString() {
  return 'InstitutionApiDto(institutionId: $institutionId, name: $name, webPages: $webPages, domains: $domains, alphaTwoCode: $alphaTwoCode, country: $country, stateProvince: $stateProvince)';
}


}

/// @nodoc
abstract mixin class _$InstitutionApiDtoCopyWith<$Res> implements $InstitutionApiDtoCopyWith<$Res> {
  factory _$InstitutionApiDtoCopyWith(_InstitutionApiDto value, $Res Function(_InstitutionApiDto) _then) = __$InstitutionApiDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'institution_id') int institutionId, String name,@JsonKey(name: 'web_pages') List<String>? webPages, List<String>? domains,@JsonKey(name: 'alpha_two_code') String? alphaTwoCode, String? country,@JsonKey(name: 'state_province') String? stateProvince
});




}
/// @nodoc
class __$InstitutionApiDtoCopyWithImpl<$Res>
    implements _$InstitutionApiDtoCopyWith<$Res> {
  __$InstitutionApiDtoCopyWithImpl(this._self, this._then);

  final _InstitutionApiDto _self;
  final $Res Function(_InstitutionApiDto) _then;

/// Create a copy of InstitutionApiDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? institutionId = null,Object? name = null,Object? webPages = freezed,Object? domains = freezed,Object? alphaTwoCode = freezed,Object? country = freezed,Object? stateProvince = freezed,}) {
  return _then(_InstitutionApiDto(
institutionId: null == institutionId ? _self.institutionId : institutionId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,webPages: freezed == webPages ? _self._webPages : webPages // ignore: cast_nullable_to_non_nullable
as List<String>?,domains: freezed == domains ? _self._domains : domains // ignore: cast_nullable_to_non_nullable
as List<String>?,alphaTwoCode: freezed == alphaTwoCode ? _self.alphaTwoCode : alphaTwoCode // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,stateProvince: freezed == stateProvince ? _self.stateProvince : stateProvince // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

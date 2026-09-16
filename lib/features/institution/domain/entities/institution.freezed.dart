// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Institution {

 int get institutionId; String get name; List<String>? get webPages; List<String>? get domains; String? get alphaTwoCode; String? get country; String? get stateProvince;
/// Create a copy of Institution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionCopyWith<Institution> get copyWith => _$InstitutionCopyWithImpl<Institution>(this as Institution, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Institution&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.webPages, webPages)&&const DeepCollectionEquality().equals(other.domains, domains)&&(identical(other.alphaTwoCode, alphaTwoCode) || other.alphaTwoCode == alphaTwoCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.stateProvince, stateProvince) || other.stateProvince == stateProvince));
}


@override
int get hashCode => Object.hash(runtimeType,institutionId,name,const DeepCollectionEquality().hash(webPages),const DeepCollectionEquality().hash(domains),alphaTwoCode,country,stateProvince);

@override
String toString() {
  return 'Institution(institutionId: $institutionId, name: $name, webPages: $webPages, domains: $domains, alphaTwoCode: $alphaTwoCode, country: $country, stateProvince: $stateProvince)';
}


}

/// @nodoc
abstract mixin class $InstitutionCopyWith<$Res>  {
  factory $InstitutionCopyWith(Institution value, $Res Function(Institution) _then) = _$InstitutionCopyWithImpl;
@useResult
$Res call({
 int institutionId, String name, List<String>? webPages, List<String>? domains, String? alphaTwoCode, String? country, String? stateProvince
});




}
/// @nodoc
class _$InstitutionCopyWithImpl<$Res>
    implements $InstitutionCopyWith<$Res> {
  _$InstitutionCopyWithImpl(this._self, this._then);

  final Institution _self;
  final $Res Function(Institution) _then;

/// Create a copy of Institution
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


/// Adds pattern-matching-related methods to [Institution].
extension InstitutionPatterns on Institution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Institution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Institution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Institution value)  $default,){
final _that = this;
switch (_that) {
case _Institution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Institution value)?  $default,){
final _that = this;
switch (_that) {
case _Institution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int institutionId,  String name,  List<String>? webPages,  List<String>? domains,  String? alphaTwoCode,  String? country,  String? stateProvince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Institution() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int institutionId,  String name,  List<String>? webPages,  List<String>? domains,  String? alphaTwoCode,  String? country,  String? stateProvince)  $default,) {final _that = this;
switch (_that) {
case _Institution():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int institutionId,  String name,  List<String>? webPages,  List<String>? domains,  String? alphaTwoCode,  String? country,  String? stateProvince)?  $default,) {final _that = this;
switch (_that) {
case _Institution() when $default != null:
return $default(_that.institutionId,_that.name,_that.webPages,_that.domains,_that.alphaTwoCode,_that.country,_that.stateProvince);case _:
  return null;

}
}

}

/// @nodoc


class _Institution implements Institution {
  const _Institution({required this.institutionId, required this.name, required final  List<String>? webPages, required final  List<String>? domains, required this.alphaTwoCode, required this.country, this.stateProvince}): _webPages = webPages,_domains = domains;
  

@override final  int institutionId;
@override final  String name;
 final  List<String>? _webPages;
@override List<String>? get webPages {
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

@override final  String? alphaTwoCode;
@override final  String? country;
@override final  String? stateProvince;

/// Create a copy of Institution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionCopyWith<_Institution> get copyWith => __$InstitutionCopyWithImpl<_Institution>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Institution&&(identical(other.institutionId, institutionId) || other.institutionId == institutionId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._webPages, _webPages)&&const DeepCollectionEquality().equals(other._domains, _domains)&&(identical(other.alphaTwoCode, alphaTwoCode) || other.alphaTwoCode == alphaTwoCode)&&(identical(other.country, country) || other.country == country)&&(identical(other.stateProvince, stateProvince) || other.stateProvince == stateProvince));
}


@override
int get hashCode => Object.hash(runtimeType,institutionId,name,const DeepCollectionEquality().hash(_webPages),const DeepCollectionEquality().hash(_domains),alphaTwoCode,country,stateProvince);

@override
String toString() {
  return 'Institution(institutionId: $institutionId, name: $name, webPages: $webPages, domains: $domains, alphaTwoCode: $alphaTwoCode, country: $country, stateProvince: $stateProvince)';
}


}

/// @nodoc
abstract mixin class _$InstitutionCopyWith<$Res> implements $InstitutionCopyWith<$Res> {
  factory _$InstitutionCopyWith(_Institution value, $Res Function(_Institution) _then) = __$InstitutionCopyWithImpl;
@override @useResult
$Res call({
 int institutionId, String name, List<String>? webPages, List<String>? domains, String? alphaTwoCode, String? country, String? stateProvince
});




}
/// @nodoc
class __$InstitutionCopyWithImpl<$Res>
    implements _$InstitutionCopyWith<$Res> {
  __$InstitutionCopyWithImpl(this._self, this._then);

  final _Institution _self;
  final $Res Function(_Institution) _then;

/// Create a copy of Institution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? institutionId = null,Object? name = null,Object? webPages = freezed,Object? domains = freezed,Object? alphaTwoCode = freezed,Object? country = freezed,Object? stateProvince = freezed,}) {
  return _then(_Institution(
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

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'magnet_fee_statement_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MagnetFeeStatementDto {

 String? get title;@JsonKey(fromJson: _parseInstitutionId) int get institution;@JsonKey(name: 'reference_number') String? get referenceNumber;@JsonKey(name: 'balance', fromJson: _parseCommaDouble) double? get runningBalance;@JsonKey(fromJson: _parseCommaDouble) double? get debit;@JsonKey(fromJson: _parseCommaDouble) double? get credit;@JsonKey(name: 'posting_date') String? get postingDateRaw; String? get date; String? get description; String? get currency;
/// Create a copy of MagnetFeeStatementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MagnetFeeStatementDtoCopyWith<MagnetFeeStatementDto> get copyWith => _$MagnetFeeStatementDtoCopyWithImpl<MagnetFeeStatementDto>(this as MagnetFeeStatementDto, _$identity);

  /// Serializes this MagnetFeeStatementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MagnetFeeStatementDto&&(identical(other.title, title) || other.title == title)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit)&&(identical(other.postingDateRaw, postingDateRaw) || other.postingDateRaw == postingDateRaw)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,institution,referenceNumber,runningBalance,debit,credit,postingDateRaw,date,description,currency);

@override
String toString() {
  return 'MagnetFeeStatementDto(title: $title, institution: $institution, referenceNumber: $referenceNumber, runningBalance: $runningBalance, debit: $debit, credit: $credit, postingDateRaw: $postingDateRaw, date: $date, description: $description, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $MagnetFeeStatementDtoCopyWith<$Res>  {
  factory $MagnetFeeStatementDtoCopyWith(MagnetFeeStatementDto value, $Res Function(MagnetFeeStatementDto) _then) = _$MagnetFeeStatementDtoCopyWithImpl;
@useResult
$Res call({
 String? title,@JsonKey(fromJson: _parseInstitutionId) int institution,@JsonKey(name: 'reference_number') String? referenceNumber,@JsonKey(name: 'balance', fromJson: _parseCommaDouble) double? runningBalance,@JsonKey(fromJson: _parseCommaDouble) double? debit,@JsonKey(fromJson: _parseCommaDouble) double? credit,@JsonKey(name: 'posting_date') String? postingDateRaw, String? date, String? description, String? currency
});




}
/// @nodoc
class _$MagnetFeeStatementDtoCopyWithImpl<$Res>
    implements $MagnetFeeStatementDtoCopyWith<$Res> {
  _$MagnetFeeStatementDtoCopyWithImpl(this._self, this._then);

  final MagnetFeeStatementDto _self;
  final $Res Function(MagnetFeeStatementDto) _then;

/// Create a copy of MagnetFeeStatementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? institution = null,Object? referenceNumber = freezed,Object? runningBalance = freezed,Object? debit = freezed,Object? credit = freezed,Object? postingDateRaw = freezed,Object? date = freezed,Object? description = freezed,Object? currency = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,runningBalance: freezed == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double?,debit: freezed == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double?,credit: freezed == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double?,postingDateRaw: freezed == postingDateRaw ? _self.postingDateRaw : postingDateRaw // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MagnetFeeStatementDto].
extension MagnetFeeStatementDtoPatterns on MagnetFeeStatementDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MagnetFeeStatementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MagnetFeeStatementDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MagnetFeeStatementDto value)  $default,){
final _that = this;
switch (_that) {
case _MagnetFeeStatementDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MagnetFeeStatementDto value)?  $default,){
final _that = this;
switch (_that) {
case _MagnetFeeStatementDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title, @JsonKey(fromJson: _parseInstitutionId)  int institution, @JsonKey(name: 'reference_number')  String? referenceNumber, @JsonKey(name: 'balance', fromJson: _parseCommaDouble)  double? runningBalance, @JsonKey(fromJson: _parseCommaDouble)  double? debit, @JsonKey(fromJson: _parseCommaDouble)  double? credit, @JsonKey(name: 'posting_date')  String? postingDateRaw,  String? date,  String? description,  String? currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MagnetFeeStatementDto() when $default != null:
return $default(_that.title,_that.institution,_that.referenceNumber,_that.runningBalance,_that.debit,_that.credit,_that.postingDateRaw,_that.date,_that.description,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title, @JsonKey(fromJson: _parseInstitutionId)  int institution, @JsonKey(name: 'reference_number')  String? referenceNumber, @JsonKey(name: 'balance', fromJson: _parseCommaDouble)  double? runningBalance, @JsonKey(fromJson: _parseCommaDouble)  double? debit, @JsonKey(fromJson: _parseCommaDouble)  double? credit, @JsonKey(name: 'posting_date')  String? postingDateRaw,  String? date,  String? description,  String? currency)  $default,) {final _that = this;
switch (_that) {
case _MagnetFeeStatementDto():
return $default(_that.title,_that.institution,_that.referenceNumber,_that.runningBalance,_that.debit,_that.credit,_that.postingDateRaw,_that.date,_that.description,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title, @JsonKey(fromJson: _parseInstitutionId)  int institution, @JsonKey(name: 'reference_number')  String? referenceNumber, @JsonKey(name: 'balance', fromJson: _parseCommaDouble)  double? runningBalance, @JsonKey(fromJson: _parseCommaDouble)  double? debit, @JsonKey(fromJson: _parseCommaDouble)  double? credit, @JsonKey(name: 'posting_date')  String? postingDateRaw,  String? date,  String? description,  String? currency)?  $default,) {final _that = this;
switch (_that) {
case _MagnetFeeStatementDto() when $default != null:
return $default(_that.title,_that.institution,_that.referenceNumber,_that.runningBalance,_that.debit,_that.credit,_that.postingDateRaw,_that.date,_that.description,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MagnetFeeStatementDto implements MagnetFeeStatementDto {
  const _MagnetFeeStatementDto({this.title, @JsonKey(fromJson: _parseInstitutionId) required this.institution, @JsonKey(name: 'reference_number') this.referenceNumber, @JsonKey(name: 'balance', fromJson: _parseCommaDouble) this.runningBalance, @JsonKey(fromJson: _parseCommaDouble) this.debit, @JsonKey(fromJson: _parseCommaDouble) this.credit, @JsonKey(name: 'posting_date') this.postingDateRaw, this.date, this.description, this.currency});
  factory _MagnetFeeStatementDto.fromJson(Map<String, dynamic> json) => _$MagnetFeeStatementDtoFromJson(json);

@override final  String? title;
@override@JsonKey(fromJson: _parseInstitutionId) final  int institution;
@override@JsonKey(name: 'reference_number') final  String? referenceNumber;
@override@JsonKey(name: 'balance', fromJson: _parseCommaDouble) final  double? runningBalance;
@override@JsonKey(fromJson: _parseCommaDouble) final  double? debit;
@override@JsonKey(fromJson: _parseCommaDouble) final  double? credit;
@override@JsonKey(name: 'posting_date') final  String? postingDateRaw;
@override final  String? date;
@override final  String? description;
@override final  String? currency;

/// Create a copy of MagnetFeeStatementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MagnetFeeStatementDtoCopyWith<_MagnetFeeStatementDto> get copyWith => __$MagnetFeeStatementDtoCopyWithImpl<_MagnetFeeStatementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MagnetFeeStatementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MagnetFeeStatementDto&&(identical(other.title, title) || other.title == title)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit)&&(identical(other.postingDateRaw, postingDateRaw) || other.postingDateRaw == postingDateRaw)&&(identical(other.date, date) || other.date == date)&&(identical(other.description, description) || other.description == description)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,institution,referenceNumber,runningBalance,debit,credit,postingDateRaw,date,description,currency);

@override
String toString() {
  return 'MagnetFeeStatementDto(title: $title, institution: $institution, referenceNumber: $referenceNumber, runningBalance: $runningBalance, debit: $debit, credit: $credit, postingDateRaw: $postingDateRaw, date: $date, description: $description, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$MagnetFeeStatementDtoCopyWith<$Res> implements $MagnetFeeStatementDtoCopyWith<$Res> {
  factory _$MagnetFeeStatementDtoCopyWith(_MagnetFeeStatementDto value, $Res Function(_MagnetFeeStatementDto) _then) = __$MagnetFeeStatementDtoCopyWithImpl;
@override @useResult
$Res call({
 String? title,@JsonKey(fromJson: _parseInstitutionId) int institution,@JsonKey(name: 'reference_number') String? referenceNumber,@JsonKey(name: 'balance', fromJson: _parseCommaDouble) double? runningBalance,@JsonKey(fromJson: _parseCommaDouble) double? debit,@JsonKey(fromJson: _parseCommaDouble) double? credit,@JsonKey(name: 'posting_date') String? postingDateRaw, String? date, String? description, String? currency
});




}
/// @nodoc
class __$MagnetFeeStatementDtoCopyWithImpl<$Res>
    implements _$MagnetFeeStatementDtoCopyWith<$Res> {
  __$MagnetFeeStatementDtoCopyWithImpl(this._self, this._then);

  final _MagnetFeeStatementDto _self;
  final $Res Function(_MagnetFeeStatementDto) _then;

/// Create a copy of MagnetFeeStatementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? institution = null,Object? referenceNumber = freezed,Object? runningBalance = freezed,Object? debit = freezed,Object? credit = freezed,Object? postingDateRaw = freezed,Object? date = freezed,Object? description = freezed,Object? currency = freezed,}) {
  return _then(_MagnetFeeStatementDto(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,runningBalance: freezed == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double?,debit: freezed == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double?,credit: freezed == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double?,postingDateRaw: freezed == postingDateRaw ? _self.postingDateRaw : postingDateRaw // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

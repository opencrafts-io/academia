// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_fee_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstitutionFeeTransaction {

 int? get id; int get institution; String? get referenceNumber; double? get runningBalance; double? get debit; double? get credit; DateTime? get postingDate; String? get description; String? get title; String? get currency;
/// Create a copy of InstitutionFeeTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstitutionFeeTransactionCopyWith<InstitutionFeeTransaction> get copyWith => _$InstitutionFeeTransactionCopyWithImpl<InstitutionFeeTransaction>(this as InstitutionFeeTransaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstitutionFeeTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.title, title) || other.title == title)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,id,institution,referenceNumber,runningBalance,debit,credit,postingDate,description,title,currency);

@override
String toString() {
  return 'InstitutionFeeTransaction(id: $id, institution: $institution, referenceNumber: $referenceNumber, runningBalance: $runningBalance, debit: $debit, credit: $credit, postingDate: $postingDate, description: $description, title: $title, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $InstitutionFeeTransactionCopyWith<$Res>  {
  factory $InstitutionFeeTransactionCopyWith(InstitutionFeeTransaction value, $Res Function(InstitutionFeeTransaction) _then) = _$InstitutionFeeTransactionCopyWithImpl;
@useResult
$Res call({
 int? id, int institution, String? referenceNumber, double? runningBalance, double? debit, double? credit, DateTime? postingDate, String? description, String? title, String? currency
});




}
/// @nodoc
class _$InstitutionFeeTransactionCopyWithImpl<$Res>
    implements $InstitutionFeeTransactionCopyWith<$Res> {
  _$InstitutionFeeTransactionCopyWithImpl(this._self, this._then);

  final InstitutionFeeTransaction _self;
  final $Res Function(InstitutionFeeTransaction) _then;

/// Create a copy of InstitutionFeeTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? institution = null,Object? referenceNumber = freezed,Object? runningBalance = freezed,Object? debit = freezed,Object? credit = freezed,Object? postingDate = freezed,Object? description = freezed,Object? title = freezed,Object? currency = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,runningBalance: freezed == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double?,debit: freezed == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double?,credit: freezed == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double?,postingDate: freezed == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstitutionFeeTransaction].
extension InstitutionFeeTransactionPatterns on InstitutionFeeTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstitutionFeeTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstitutionFeeTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstitutionFeeTransaction value)  $default,){
final _that = this;
switch (_that) {
case _InstitutionFeeTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstitutionFeeTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _InstitutionFeeTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int institution,  String? referenceNumber,  double? runningBalance,  double? debit,  double? credit,  DateTime? postingDate,  String? description,  String? title,  String? currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstitutionFeeTransaction() when $default != null:
return $default(_that.id,_that.institution,_that.referenceNumber,_that.runningBalance,_that.debit,_that.credit,_that.postingDate,_that.description,_that.title,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int institution,  String? referenceNumber,  double? runningBalance,  double? debit,  double? credit,  DateTime? postingDate,  String? description,  String? title,  String? currency)  $default,) {final _that = this;
switch (_that) {
case _InstitutionFeeTransaction():
return $default(_that.id,_that.institution,_that.referenceNumber,_that.runningBalance,_that.debit,_that.credit,_that.postingDate,_that.description,_that.title,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int institution,  String? referenceNumber,  double? runningBalance,  double? debit,  double? credit,  DateTime? postingDate,  String? description,  String? title,  String? currency)?  $default,) {final _that = this;
switch (_that) {
case _InstitutionFeeTransaction() when $default != null:
return $default(_that.id,_that.institution,_that.referenceNumber,_that.runningBalance,_that.debit,_that.credit,_that.postingDate,_that.description,_that.title,_that.currency);case _:
  return null;

}
}

}

/// @nodoc


class _InstitutionFeeTransaction implements InstitutionFeeTransaction {
  const _InstitutionFeeTransaction({this.id, required this.institution, this.referenceNumber, this.runningBalance = 0.0, this.debit = 0.0, this.credit = 0.0, this.postingDate, this.description, this.title, this.currency = "KES"});
  

@override final  int? id;
@override final  int institution;
@override final  String? referenceNumber;
@override@JsonKey() final  double? runningBalance;
@override@JsonKey() final  double? debit;
@override@JsonKey() final  double? credit;
@override final  DateTime? postingDate;
@override final  String? description;
@override final  String? title;
@override@JsonKey() final  String? currency;

/// Create a copy of InstitutionFeeTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstitutionFeeTransactionCopyWith<_InstitutionFeeTransaction> get copyWith => __$InstitutionFeeTransactionCopyWithImpl<_InstitutionFeeTransaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstitutionFeeTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.referenceNumber, referenceNumber) || other.referenceNumber == referenceNumber)&&(identical(other.runningBalance, runningBalance) || other.runningBalance == runningBalance)&&(identical(other.debit, debit) || other.debit == debit)&&(identical(other.credit, credit) || other.credit == credit)&&(identical(other.postingDate, postingDate) || other.postingDate == postingDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.title, title) || other.title == title)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,id,institution,referenceNumber,runningBalance,debit,credit,postingDate,description,title,currency);

@override
String toString() {
  return 'InstitutionFeeTransaction(id: $id, institution: $institution, referenceNumber: $referenceNumber, runningBalance: $runningBalance, debit: $debit, credit: $credit, postingDate: $postingDate, description: $description, title: $title, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$InstitutionFeeTransactionCopyWith<$Res> implements $InstitutionFeeTransactionCopyWith<$Res> {
  factory _$InstitutionFeeTransactionCopyWith(_InstitutionFeeTransaction value, $Res Function(_InstitutionFeeTransaction) _then) = __$InstitutionFeeTransactionCopyWithImpl;
@override @useResult
$Res call({
 int? id, int institution, String? referenceNumber, double? runningBalance, double? debit, double? credit, DateTime? postingDate, String? description, String? title, String? currency
});




}
/// @nodoc
class __$InstitutionFeeTransactionCopyWithImpl<$Res>
    implements _$InstitutionFeeTransactionCopyWith<$Res> {
  __$InstitutionFeeTransactionCopyWithImpl(this._self, this._then);

  final _InstitutionFeeTransaction _self;
  final $Res Function(_InstitutionFeeTransaction) _then;

/// Create a copy of InstitutionFeeTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? institution = null,Object? referenceNumber = freezed,Object? runningBalance = freezed,Object? debit = freezed,Object? credit = freezed,Object? postingDate = freezed,Object? description = freezed,Object? title = freezed,Object? currency = freezed,}) {
  return _then(_InstitutionFeeTransaction(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as int,referenceNumber: freezed == referenceNumber ? _self.referenceNumber : referenceNumber // ignore: cast_nullable_to_non_nullable
as String?,runningBalance: freezed == runningBalance ? _self.runningBalance : runningBalance // ignore: cast_nullable_to_non_nullable
as double?,debit: freezed == debit ? _self.debit : debit // ignore: cast_nullable_to_non_nullable
as double?,credit: freezed == credit ? _self.credit : credit // ignore: cast_nullable_to_non_nullable
as double?,postingDate: freezed == postingDate ? _self.postingDate : postingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

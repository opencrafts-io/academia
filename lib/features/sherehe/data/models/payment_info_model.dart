import 'package:drift/drift.dart';

@DataClassName('PaymentInfoData')
class PaymentInfoTable extends Table {
  @JsonKey('id')
  TextColumn get id => text()();

  @JsonKey('payment_type')
  TextColumn get paymentType => text()();

  @JsonKey('paybill_number')
  TextColumn get paybillNumber => text().nullable()();

  @JsonKey('paybill_account_number')
  TextColumn get paybillAccountNumber => text().nullable()();

  @JsonKey('till_number')
  TextColumn get tillNumber => text().nullable()();

  @JsonKey('phone_number')
  TextColumn get phoneNumber => text().nullable()();

  @JsonKey('created_at')
  TextColumn get createdAt => text()();

  @JsonKey('updated_at')
  TextColumn get updatedAt => text()();

  @JsonKey('deleted_at')
  TextColumn get deletedAt => text().nullable()();
}

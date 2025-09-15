// lib/src/data/financial_transactions_table.dart
import 'package:drift/drift.dart';

class MagnetFinancialTransaction extends Table {
  // Verisafe's user id.
  TextColumn get userID => text().named('user_id')();

  // The institution ID.
  IntColumn get institutionID => integer().named('institution_id')();

  // The unique identifier for the transaction.
  TextColumn get transactionId => text().named('transaction_id')();

  // The amount of the transaction.
  RealColumn get amount => real().named('amount')();

  // The date of the transaction.
  DateTimeColumn get date => dateTime().named('date')();

  // The type of transaction (e.g., "credit" or "debit").
  TextColumn get type => text().named('type')();

  // The payment method (e.g., "mpesa", "card", "cash").
  TextColumn get paymentMethod => text().named('payment_method')();

  // The student's ID.
  TextColumn get studentId => text().named('student_id')();

  // The student's balance after the transaction.
  RealColumn get balanceAfterTransaction =>
      real().named('balance_after_transaction')();

  // The status of the transaction (e.g., "pending", "completed", "failed").
  TextColumn get status => text().named('status')();

  // The currency of the transaction.
  TextColumn get currency => text().named('currency')();

  // A brief description of the transaction.
  TextColumn get description => text().nullable().named('description')();

  // The transaction's reference number.
  TextColumn get referenceNumber =>
      text().nullable().named('reference_number')();
  // A composite primary key to uniquely identify each transaction.
  @override
  Set<Column> get primaryKey => {userID, institutionID, transactionId};
}

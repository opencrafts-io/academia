import 'package:academia/database/database.dart';
import 'package:academia/features/magnet/domain/domain.dart';
import 'package:magnet/magnet.dart';

extension MagnetFinancialTransactionExtension on MagnetFinancialTransaction {
  MagnetFinancialTransactionData toData() => MagnetFinancialTransactionData(
    userID: userID,
    institutionID: institutionID,
    transactionId: transactionId,
    amount: amount,
    date: date,
    type: type,
    paymentMethod: paymentMethod,
    studentId: studentId,
    balanceAfterTransaction: balanceAfterTransaction,
    status: status,
    currency: currency,
    description: description,
    referenceNumber: referenceNumber,
  );
}

extension MagnetFinancialTransactionDataExtension
    on MagnetFinancialTransactionData {
  MagnetFinancialTransaction toEntity() => MagnetFinancialTransaction(
    userID: userID,
    institutionID: institutionID,
    transactionId: transactionId,
    amount: amount,
    date: date,
    type: type,
    paymentMethod: paymentMethod,
    studentId: studentId,
    balanceAfterTransaction: balanceAfterTransaction,
    status: status,
    currency: currency,
    description: description,
    referenceNumber: referenceNumber,
  );
}

extension FinancialTransactionExtension on FinancialTransaction {
  MagnetFinancialTransactionData toData({
    required userID,
    required institutionID,
  }) => MagnetFinancialTransactionData(
    userID: userID,
    institutionID: institutionID,
    transactionId: transactionId,
    amount: amount,
    date: date ?? DateTime.now(),
    type: transactionType ?? 'Unkown',
    paymentMethod: paymentMethod ?? '',
    studentId: studentId,
    balanceAfterTransaction: balanceAfterTransaction,
    status: status ?? '',
    currency: currency ?? 'KES',
    referenceNumber: transactionReference,
    description: description,
  );
  MagnetFinancialTransaction toEntity({
    required userID,
    required institutionID,
  }) => MagnetFinancialTransaction(
    userID: userID,
    institutionID: institutionID,
    transactionId: transactionId,
    amount: amount,
    date: date ?? DateTime.now(),
    type: transactionType ?? 'Unkown',
    paymentMethod: paymentMethod ?? '',
    studentId: studentId,
    balanceAfterTransaction: balanceAfterTransaction,
    status: status ?? '',
    currency: currency ?? 'KES',
    referenceNumber: transactionReference,
    description: description,
  );
}

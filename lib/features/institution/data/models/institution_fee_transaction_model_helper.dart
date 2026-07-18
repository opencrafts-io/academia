import 'package:academia/database/database.dart' as db;
import 'package:academia/features/institution/institution.dart';

extension InstitutionFeeTransactionModelHelper
    on db.InstitutionFeeTransaction {
  InstitutionFeeTransaction toEntity() => InstitutionFeeTransaction(
    id: id,
    institution: institution,
    referenceNumber: referenceNumber,
    runningBalance: runningBalance,
    debit: debit,
    credit: credit,
    postingDate: postingDate,
    description: description,
    title: title,
    currency: currency,
  );
}

extension InstitutionFeeTransactionHelper on InstitutionFeeTransaction {
  db.InstitutionFeeTransaction toData() => db.InstitutionFeeTransaction(
    id: id,
    institution: institution,
    referenceNumber: referenceNumber,
    runningBalance: runningBalance ?? 0.0,
    debit: debit ?? 0.0,
    credit: credit ?? 0.0,
    postingDate: postingDate,
    description: description,
    title: title,
    currency: currency ?? "KES",
  );
}

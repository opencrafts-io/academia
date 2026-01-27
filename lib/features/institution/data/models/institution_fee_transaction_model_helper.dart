import 'package:academia/database/database.dart';
import 'package:academia/features/institution/institution.dart';

extension InstitutionFeeTransactionModelHelper
    on InstitutionFeeTransactionData {
  InstitutionFeeTransaction toEntity() =>
      InstitutionFeeTransaction.fromJson(toJson());
}

extension InstitutionFeeTransactionHelper on InstitutionFeeTransaction {
  InstitutionFeeTransactionData toData() =>
      InstitutionFeeTransactionData.fromJson(toJson());
}

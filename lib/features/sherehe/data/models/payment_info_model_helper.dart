import 'package:academia/database/database.dart';
import 'package:academia/features/sherehe/domain/domain.dart';

extension PaymentInfoModelHelper on PaymentInfoData {
  PaymentInfo toEntity() => PaymentInfo(
    id: id,
    paymentType: paymentType,
    paybillNumber: paybillNumber,
    paybillAccountNumber: paybillAccountNumber,
    tillNumber: tillNumber,
    phoneNumber: phoneNumber,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}

extension PaymentInfoEntityHelper on PaymentInfo {
  PaymentInfoData toModel() => PaymentInfoData(
    id: id,
    paymentType: paymentType,
    paybillNumber: paybillNumber,
    paybillAccountNumber: paybillAccountNumber,
    tillNumber: tillNumber,
    phoneNumber: phoneNumber,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}

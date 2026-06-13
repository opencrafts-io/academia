import 'package:academia/features/sherehe/data/models/attendee_model_helper.dart';
import 'package:academia/features/sherehe/data/models/confirm_payment_model.dart';
import 'package:academia/features/sherehe/domain/entities/confirm_payment_entity.dart';

extension ConfirmPaymentModelHelper on ConfirmPaymentModel {
  ConfirmPaymentEntity toEntity() =>
      ConfirmPaymentEntity(status: status, attendee: attendeeData.toEntity());
}

extension ConfirmPaymentEntityHelper on ConfirmPaymentEntity {
  ConfirmPaymentModel toModel() =>
      ConfirmPaymentModel(status: status, attendeeData: attendee.toModel());
}

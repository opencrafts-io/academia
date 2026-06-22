import 'package:academia/features/sherehe/data/models/attendee_model_helper.dart';
import 'package:academia/features/sherehe/data/models/confirm_payment_model.dart';
import 'package:academia/features/sherehe/domain/entities/confirm_payment_entity.dart';

extension ConfirmPaymentModelHelper on ConfirmPaymentModel {
  ConfirmPaymentEntity toEntity() => ConfirmPaymentEntity(
    status: status,
    attendees: attendeesData?.map((e) => e.toEntity()).toList(),
  );
}

extension ConfirmPaymentEntityHelper on ConfirmPaymentEntity {
  ConfirmPaymentModel toModel() => ConfirmPaymentModel(
    status: status,
    attendeesData: attendees?.map((e) => e.toModel()).toList(),
  );
}

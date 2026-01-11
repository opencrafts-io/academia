import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ConfirmPaymentUseCase {
  final ShereheRepository repository;

  ConfirmPaymentUseCase(this.repository);

  Future<Either<Failure, String>> call({required String transId}) async {
    return repository.confirmPayment(transId: transId);
  }
}

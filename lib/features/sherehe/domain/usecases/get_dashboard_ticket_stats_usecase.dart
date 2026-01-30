import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/core/core.dart';

class GetDashboardTicketStatsUsecase {
  final ShereheRepository repository;

  GetDashboardTicketStatsUsecase(this.repository);

  Future<Either<Failure, List<TicketStats>>> call({
    required String eventId,
  }) async {
    return repository.getDashboardTicketStats(eventId: eventId);
  }
}

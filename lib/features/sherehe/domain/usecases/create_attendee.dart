import 'package:academia/core/core.dart';
import 'package:academia/features/sherehe/domain/domain.dart';
import 'package:dartz/dartz.dart';

class CreateAttendeeUseCase {
  final ShereheRepository repository;

  CreateAttendeeUseCase(this.repository);

  Future<Either<Failure, Attendee>> call(Attendee attendee) async {
    return await repository.createAttendee(attendee);
  }

  @override
  List<Object> get props => [repository];
}
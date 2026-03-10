import 'package:dartz/dartz.dart'; // For Either
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

abstract class UseCase<Type_, Params> {
  Future<Either<Failure, Type_>> call(Params params);
}

abstract class StreamUseCase<Type_, Params> {
  Stream<Type_> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

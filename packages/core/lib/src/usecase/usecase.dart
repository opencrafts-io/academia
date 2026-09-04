import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class StreamUseCase<T, Params> {
  Stream<T> call(Params params);
}

// A representation of empty parameters
// to a usecase
class NoUseCaseParams {
  const NoUseCaseParams();
}

import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/features.dart';
import 'package:dartz/dartz.dart';

class SignInAsReviewUsecase extends UseCase<Token, NoParams> {
  final AuthRepository repository;

  SignInAsReviewUsecase({required this.repository});
  @override
  Future<Either<Failure, Token>> call(NoParams params)async {
    return await repository.reviewSignIn();
  } 
}

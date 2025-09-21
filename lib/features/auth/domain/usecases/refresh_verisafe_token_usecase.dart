import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

class RefreshVerisafeTokenUsecase implements UseCase<Token, Token> {
  final AuthRepository authRepository;

  RefreshVerisafeTokenUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Token>> call(Token token) {
    return authRepository.refreshVerisafeToken(token);
  }
}

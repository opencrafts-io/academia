import 'package:core/core.dart';
import 'package:auth/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class RefreshVerisafeTokenUsecase implements UseCase<Token, Token> {
  final AuthRepository authRepository;

  RefreshVerisafeTokenUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Token>> call(Token token) {
    return authRepository.refreshVerisafeToken(token);
  }
}

import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/auth/domain/repository/auth_repository.dart';
import 'package:academia/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;
  late SignOutUsecase usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = SignOutUsecase(authRepository: mockRepository);
  });

  group('SignOutUsecase', () {
    test('should call repository.signout and return Right(null) on success',
        () async {
      when(() => mockRepository.signout())
          .thenAnswer((_) async => right(null));

      final result = await usecase(NoParams());

      expect(result.isRight(), true);
      verify(() => mockRepository.signout()).called(1);
    });

    test('should return Failure when repository.signout fails', () async {
      final failure = CacheFailure(
        message: 'Failed to clear tokens',
        error: Exception('storage error'),
      );
      when(() => mockRepository.signout())
          .thenAnswer((_) async => left(failure));

      final result = await usecase(NoParams());

      expect(result.isLeft(), true);
      result.fold(
        (f) => expect(f, failure),
        (_) => fail('Expected Left'),
      );
    });

    test('should always call repository.signout exactly once', () async {
      when(() => mockRepository.signout())
          .thenAnswer((_) async => right(null));

      await usecase(NoParams());

      verify(() => mockRepository.signout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass NoParams and not interact with anything else', () async {
      when(() => mockRepository.signout())
          .thenAnswer((_) async => right(null));

      final result = await usecase(NoParams());

      expect(result.isRight(), true);
      verifyNever(() => mockRepository.signInWithGoogle());
      verifyNever(() => mockRepository.signInWithApple());
    });
  });
}
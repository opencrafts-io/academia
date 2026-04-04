import 'package:academia/config/flavor.dart';
import 'package:academia/core/error/failures.dart';
import 'package:academia/core/usecase/usecase.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/auth/domain/usecases/sign_in_with_provider_usecase.dart';
import 'package:academia/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:academia/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:academia/injection_container.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockSignInWithGoogle extends Mock implements SignInWithGoogleUsecase {}

class MockSignInWithSpotify extends Mock implements SignInWithSpotifyUsecase {}

class MockSignInWithApple extends Mock implements SignInWithAppleUsecase {}

class MockGetPreviousAuthState extends Mock implements GetPreviousAuthState {}

class MockRefreshVerisafeToken extends Mock
    implements RefreshVerisafeTokenUsecase {}

class MockSignInAsReview extends Mock implements SignInAsReviewUsecase {}

class MockSignInWithProvider extends Mock
    implements SignInWithProviderUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

void main() {
  late MockSignInWithGoogle mockSignInWithGoogle;
  late MockSignInWithSpotify mockSignInWithSpotify;
  late MockSignInWithApple mockSignInWithApple;
  late MockGetPreviousAuthState mockGetPreviousAuthState;
  late MockRefreshVerisafeToken mockRefreshVerisafeToken;
  late MockSignInAsReview mockSignInAsReview;
  late MockSignInWithProvider mockSignInWithProvider;
  late MockSignOutUsecase mockSignOutUsecase;

  final tAccessExpiresAt = DateTime.utc(2026, 6, 1, 12, 0, 0);
  final tRefreshExpiresAt = DateTime.utc(2026, 12, 1, 12, 0, 0);

  final tToken = Token(
    provider: 'verisafe',
    accessToken: 'access-token-123',
    refreshToken: 'refresh-token-456',
    accessExpiresAt: tAccessExpiresAt,
    refreshExpiresAt: tRefreshExpiresAt,
  );

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(AuthProvider.google);
    registerFallbackValue(tToken);
  });

  setUp(() {
    mockSignInWithGoogle = MockSignInWithGoogle();
    mockSignInWithSpotify = MockSignInWithSpotify();
    mockSignInWithApple = MockSignInWithApple();
    mockGetPreviousAuthState = MockGetPreviousAuthState();
    mockRefreshVerisafeToken = MockRefreshVerisafeToken();
    mockSignInAsReview = MockSignInAsReview();
    mockSignInWithProvider = MockSignInWithProvider();
    mockSignOutUsecase = MockSignOutUsecase();

    // Register a development FlavorConfig so sl<FlavorConfig>() works in the bloc.
    if (!sl.isRegistered<FlavorConfig>()) {
      sl.registerSingleton<FlavorConfig>(
        FlavorConfig(
          flavor: Flavor.development,
          appName: 'Test',
          apiBaseUrl: 'https://api.test.io',
        ),
      );
    }
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  AuthBloc buildBloc() => AuthBloc(
        signInWithGoogle: mockSignInWithGoogle,
        signInWithSpotifyUsecase: mockSignInWithSpotify,
        signInWithAppleUsecase: mockSignInWithApple,
        getPreviousAuthState: mockGetPreviousAuthState,
        refreshVerisafeTokenUsecase: mockRefreshVerisafeToken,
        signInAsReviewUsecase: mockSignInAsReview,
        signInWithProviderUsecase: mockSignInWithProvider,
        signOutUsecase: mockSignOutUsecase,
      );

  group('AuthBloc', () {
    group('AuthSignInWithProviderEvent', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when signInWithProviderUsecase succeeds',
        build: buildBloc,
        act: (bloc) => bloc.add(
          const AuthSignInWithProviderEvent(authProvider: AuthProvider.google),
        ),
        setUp: () {
          when(() => mockSignInWithProvider(AuthProvider.google))
              .thenAnswer((_) async => right(tToken));
        },
        expect: () => [
          const AuthLoading(),
          AuthAuthenticated(token: tToken),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when signInWithProviderUsecase returns AuthenticationFailure',
        build: buildBloc,
        act: (bloc) => bloc.add(
          const AuthSignInWithProviderEvent(authProvider: AuthProvider.apple),
        ),
        setUp: () {
          when(() => mockSignInWithProvider(AuthProvider.apple))
              .thenAnswer((_) async => left(AuthenticationFailure(
                    message: 'User cancelled',
                    error: Exception('cancelled'),
                  )));
        },
        expect: () => [
          const AuthLoading(),
          const AuthError(message: 'User cancelled'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] for spotify provider',
        build: buildBloc,
        act: (bloc) => bloc.add(
          const AuthSignInWithProviderEvent(authProvider: AuthProvider.spotify),
        ),
        setUp: () {
          when(() => mockSignInWithProvider(AuthProvider.spotify))
              .thenAnswer((_) async => right(tToken));
        },
        expect: () => [
          const AuthLoading(),
          AuthAuthenticated(token: tToken),
        ],
      );
    });

    group('AuthSignOutEvent', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when signOutUsecase succeeds',
        build: buildBloc,
        act: (bloc) => bloc.add(const AuthSignOutEvent()),
        setUp: () {
          when(() => mockSignOutUsecase(any()))
              .thenAnswer((_) async => right(null));
        },
        expect: () => [
          const AuthLoading(),
          AuthUnauthenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when signOutUsecase returns a Failure',
        build: buildBloc,
        act: (bloc) => bloc.add(const AuthSignOutEvent()),
        setUp: () {
          when(() => mockSignOutUsecase(any())).thenAnswer((_) async => left(
                CacheFailure(
                  message: 'Failed to clear tokens',
                  error: Exception('storage error'),
                ),
              ));
        },
        expect: () => [
          const AuthLoading(),
          const AuthError(message: 'Failed to clear tokens'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'calls signOutUsecase exactly once on AuthSignOutEvent',
        build: buildBloc,
        act: (bloc) => bloc.add(const AuthSignOutEvent()),
        setUp: () {
          when(() => mockSignOutUsecase(any()))
              .thenAnswer((_) async => right(null));
        },
        verify: (_) {
          verify(() => mockSignOutUsecase(any())).called(1);
        },
      );
    });

    group('AuthCheckStatusEvent', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when a valid verisafe token exists',
        build: buildBloc,
        act: (bloc) => bloc.add(const AuthCheckStatusEvent()),
        setUp: () {
          // Token with refresh that expires in the future
          final validToken = Token(
            provider: 'verisafe',
            accessToken: 'access',
            refreshToken: 'refresh',
            accessExpiresAt: DateTime.now().add(const Duration(hours: 1)),
            refreshExpiresAt: DateTime.now().add(const Duration(days: 30)),
          );
          when(() => mockGetPreviousAuthState(any()))
              .thenAnswer((_) async => right([validToken]));
          when(() => mockRefreshVerisafeToken(any()))
              .thenAnswer((_) async => right(validToken));
        },
        expect: () => [
          const AuthLoading(),
          isA<AuthAuthenticated>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when no valid token exists',
        build: buildBloc,
        act: (bloc) => bloc.add(const AuthCheckStatusEvent()),
        setUp: () {
          // Token with expired refresh
          final expiredToken = Token(
            provider: 'verisafe',
            accessToken: 'access',
            refreshToken: 'refresh',
            accessExpiresAt: DateTime.now().subtract(const Duration(days: 10)),
            refreshExpiresAt:
                DateTime.now().subtract(const Duration(days: 1)),
          );
          when(() => mockGetPreviousAuthState(any()))
              .thenAnswer((_) async => right([expiredToken]));
        },
        expect: () => [
          const AuthLoading(),
          isA<AuthUnauthenticated>(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when getPreviousAuthState fails',
        build: buildBloc,
        act: (bloc) => bloc.add(const AuthCheckStatusEvent()),
        setUp: () {
          when(() => mockGetPreviousAuthState(any())).thenAnswer((_) async =>
              left(AuthenticationFailure(
                message: 'Cache read failed',
                error: Exception('error'),
              )));
        },
        expect: () => [
          const AuthLoading(),
          const AuthError(message: 'Cache read failed'),
        ],
      );
    });

    test('initial state should be AuthInitial', () {
      expect(buildBloc().state, const AuthInitial());
    });
  });
}
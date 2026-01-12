import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUsecase signInWithGoogle;
  final SignInWithSpotifyUsecase signInWithSpotifyUsecase;
  final SignInWithAppleUsecase signInWithAppleUsecase;
  final GetPreviousAuthState getPreviousAuthState;
  final RefreshVerisafeTokenUsecase refreshVerisafeTokenUsecase;
  final SignInAsReviewUsecase signInAsReviewUsecase;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signInWithSpotifyUsecase,
    required this.getPreviousAuthState,
    required this.refreshVerisafeTokenUsecase,
    required this.signInAsReviewUsecase,
    required this.signInWithAppleUsecase,
  }) : super(const AuthInitial()) {
    // Register event handlers
    on<AuthSignInAsReviewerEvent>(_onSignInAsReviewer);
    on<AuthSignInWithGoogleEvent>(_onSignInWithGoogle);
    on<AuthSignInWithAppleEvent>(_onSignInWithApple);
    on<AuthSignInWithSpotifyEvent>(_onSignInWithSpotify);
    on<AuthCheckStatusEvent>(_onAppLaunched);
  }

  // --- Event Handlers ---

  Future<void> _onSignInWithSpotify(
    AuthSignInWithSpotifyEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state

    final result = await signInWithSpotifyUsecase(NoParams());

    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (token) => emit(AuthAuthenticated(token: token)),
    );
  }

  Future<void> _onSignInAsReviewer(
    AuthSignInAsReviewerEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state

    final result = await signInAsReviewUsecase(NoParams());

    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (token) => emit(AuthAuthenticated(token: token)),
    );
  }

  Future<void> _onSignInWithGoogle(
    AuthSignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state

    final result = await signInWithGoogle(NoParams());

    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (token) => emit(AuthAuthenticated(token: token)),
    );
  }

  Future<void> _onSignInWithApple(
    AuthSignInWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state

    final result = await signInWithAppleUsecase(NoParams());

    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (token) => emit(AuthAuthenticated(token: token)),
    );
  }

  Future<void> _onAppLaunched(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state
    final result = await getPreviousAuthState(NoParams());
    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (tokens) {
        if (tokens.any(
          (token) =>
              token.provider == "verisafe" &&
              (token.expiresAt?.isAfter(DateTime.now()) ?? false),
        )) {
          // -- Attempt to refresh verisafe's token
          refreshVerisafeTokenUsecase(tokens.first);
          return emit(AuthAuthenticated(token: tokens.first));
        }
        return emit(AuthUnauthenticated());
      },
    );
  }
}

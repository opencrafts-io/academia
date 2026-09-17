import 'dart:async';

import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:analytics/analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:notifications/notifications.dart';

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
  final SignInWithProviderUsecase signInWithProviderUsecase;
  final SignOutUsecase signOutUsecase;
  final AnalyticsTracker analyticsTracker;
  final NotificationIdentityService notificationIdentityService;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signInWithSpotifyUsecase,
    required this.getPreviousAuthState,
    required this.refreshVerisafeTokenUsecase,
    required this.signInAsReviewUsecase,
    required this.signInWithAppleUsecase,
    required this.signInWithProviderUsecase,
    required this.signOutUsecase,
    required this.analyticsTracker,
    required this.notificationIdentityService,
  }) : super(const AuthInitial()) {
    // Register event handlers
    on<AuthSignInAsReviewerEvent>(_onSignInAsReviewer);
    on<AuthSignInWithGoogleEvent>(_onSignInWithGoogle);
    on<AuthSignInWithProviderEvent>(_onSignInWithProvider);
    on<AuthSignInWithAppleEvent>(_onSignInWithApple);
    on<AuthSignInWithSpotifyEvent>(_onSignInWithSpotify);
    on<AuthCheckStatusEvent>(_onAppLaunched);
    on<AuthSignOutEvent>(_onSignOut);
  }

  // --- Event Handlers ---
  Future<void> _onSignInWithProvider(
    AuthSignInWithProviderEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state

    final result = await signInWithProviderUsecase(event.authProvider);

    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (token) {
        _recordSignIn(AnalyticsSignInMethod.provider);
        emit(AuthAuthenticated(token: token));
      },
    );
  }

  Future<void> _onSignInWithSpotify(
    AuthSignInWithSpotifyEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state

    final result = await signInWithSpotifyUsecase(NoParams());

    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (token) {
        _recordSignIn(AnalyticsSignInMethod.spotify);

        emit(AuthAuthenticated(token: token));
      },
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
      (token) {
        _recordSignIn(AnalyticsSignInMethod.reviewer);

        emit(AuthAuthenticated(token: token));
      },
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
      (token) {
        _recordSignIn(AnalyticsSignInMethod.google);

        emit(AuthAuthenticated(token: token));
      },
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
      (token) {
        _recordSignIn(AnalyticsSignInMethod.apple);

        emit(AuthAuthenticated(token: token));
      },
    );
  }

  Future<void> _onAppLaunched(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    Logger().i("-- Starting app launch token refresh");
    emit(const AuthLoading());
    final result = await getPreviousAuthState(NoParams());

    await result.fold(
      (failure) async =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (tokens) async {
        if (tokens.isEmpty) {
          Logger().i("No tokens found. New user or cleared session.");
          return emit(AuthUnauthenticated());
        }
        final targetToken = tokens.firstWhere(
          (token) => token.provider == "verisafe",
          orElse: () => tokens.first,
        );

        final hasValidVerisafeToken = tokens.any(
          (token) =>
              token.provider == "verisafe" &&
              token.refreshExpiresAt.isAfter(DateTime.now()),
        );

        if (hasValidVerisafeToken) {
          final refreshResult = await refreshVerisafeTokenUsecase(targetToken);
          Logger().i("-- Completed app launch token refresh");
          return refreshResult.fold(
            (failure) {
              // If it's a network issue, let them in anyway using their cached token!
              if (failure is NetworkFailure) {
                Logger().i(
                  "Token refresh failed due to offline status. Proceeding offline.",
                );
                return emit(AuthAuthenticated(token: targetToken));
              }
              Logger().e(
                "Token refresh rejected by server: ${failure.message}",
              );
              return emit(AuthUnauthenticated());
            },
            (newTokens) {
              return emit(AuthAuthenticated(token: newTokens));
            },
          );
        }

        return emit(AuthUnauthenticated());
      },
    );
  }

  Future<void> _onSignOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await signOutUsecase(NoParams());
    result.fold(
      (failure) {
        emit(AuthError(message: failure.message));
      },
      (success) {
        unawaited(analyticsTracker.track(AnalyticsEvent.signOutCompleted()));
        unawaited(analyticsTracker.reset());
        unawaited(notificationIdentityService.clear());
        emit(AuthUnauthenticated());
      },
    );
  }

  void _recordSignIn(AnalyticsSignInMethod method) {
    unawaited(analyticsTracker.track(AnalyticsEvent.signInCompleted(method)));
  }
}

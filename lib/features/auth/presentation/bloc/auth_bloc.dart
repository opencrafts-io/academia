import 'package:academia/core/core.dart';
import 'package:academia/features/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUsecase signInWithGoogle;
  final GetPreviousAuthState getPreviousAuthState;

  AuthBloc({required this.signInWithGoogle, required this.getPreviousAuthState})
    : super(const AuthInitial()) {
    // Register event handlers
    on<AuthSignInWithGoogleEvent>(_onSignInWithGoogle);
    on<AuthCheckStatusEvent>(_onAppLaunched);

    add(AuthCheckStatusEvent());
  }

  // --- Event Handlers ---

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

  Future<void> _onAppLaunched(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading()); // Show loading state
    final result = await getPreviousAuthState(NoParams());
    result.fold(
      (failure) =>
          emit(AuthError(message: (failure as AuthenticationFailure).message)),
      (token) => emit(AuthAuthenticated(token: token.first)),
    );
  }
}

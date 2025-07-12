part of 'auth_bloc.dart';

/// Abstract base class for all authentication states.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

/// Initial state of the authentication bloc.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State indicating that an authentication operation is in progress.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State indicating that a user is successfully authenticated.
class AuthAuthenticated extends AuthState {
  final Token token; // The authenticated user's profile

  const AuthAuthenticated({required this.token});

  @override
  List<Object> get props => [token];
}

/// State indicating that no user is currently authenticated.
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// State indicating that an authentication operation failed.
class AuthError extends AuthState {
  final String message; // User-friendly error message

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

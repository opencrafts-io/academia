part of 'auth_bloc.dart';

/// Abstract base class for all authentication events.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Event dispatched to trigger a sign-in process, typically with Google.
class AuthSignInWithGoogleEvent extends AuthEvent {
  const AuthSignInWithGoogleEvent();
}

/// Event dispatched to trigger a sign-in process, typically with Apple.
class AuthSignInWithAppleEvent extends AuthEvent {
  const AuthSignInWithAppleEvent();
}

/// Event dispatched to trigger a sign-in process as a reviewer
class AuthSignInAsReviewerEvent extends AuthEvent {}

/// Event dispatched to trigger a sign-in process, typically with Spotify.
class AuthSignInWithSpotifyEvent extends AuthEvent {
  const AuthSignInWithSpotifyEvent();
}

/// Event dispatched to check the current authentication status of the user
/// (e.g., on app start).
class AuthCheckStatusEvent extends AuthEvent {
  const AuthCheckStatusEvent();
}

/// Event dispatched to trigger a sign-out process.
class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();
}

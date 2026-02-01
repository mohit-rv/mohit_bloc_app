import 'package:meta/meta.dart';

@immutable
sealed class AuthState {}

/// Show login screen initially
class AuthInitial extends AuthState {}

/// Loading while logging in
class AuthLoading extends AuthState {}

/// Success — login done
class AuthAuthenticated extends AuthState {
  final String token;
  AuthAuthenticated(this.token);
}

/// Failed login
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

/// User logged out
class AuthLoggedOut extends AuthState {}

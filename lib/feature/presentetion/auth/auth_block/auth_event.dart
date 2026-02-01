import 'package:meta/meta.dart';

@immutable
sealed class AuthEvent {}

/// User entered email/password and pressed Login button
class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });
}

/// Check if user already logged in (auto login)
class CheckLoginStatus extends AuthEvent {}

/// Logout event
class LogoutEvent extends AuthEvent {}


part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthIdle extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthConfirmationNeeded extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthCodeResended extends AuthState {
  @override
  List<Object?> get props => [];
}

enum AuthException { emailExists, wrongCredentials, unknownError }

class AuthError extends AuthState {
  AuthError(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}

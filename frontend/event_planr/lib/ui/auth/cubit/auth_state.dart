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

class AuthError extends AuthState {

  AuthError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AuthConfirm extends AuthState {
  @override
  List<Object?> get props => [];
}

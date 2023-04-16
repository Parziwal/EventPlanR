import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthIdle());

  final AuthRepository _authRepository;

  Future<void> login(LoginCredentials credentials) async {
    emit(AuthLoading());
    try {
      await _authRepository.loginUser(credentials);
      emit(AuthSuccess());
    } on CognitoUserConfirmationNecessaryException catch (_) {
      emit(AuthConfirmationNeeded());
    } on Exception catch (e) {
      emit(AuthError(e));
    } finally {
      emit(AuthIdle());
    }
  }

  Future<void> signUp(SignUpCredentials credentials) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUpUser(credentials);
      emit(AuthConfirmationNeeded());
    } on Exception catch (e) {
      emit(AuthError(e));
    } finally {
      emit(AuthIdle());
    }
  }

  Future<void> autoLogin() async {
    emit(AuthLoading());
    final isAuthenticated = await _authRepository.autoLogin();
    if (isAuthenticated) {
      emit(AuthSuccess());
    }
    emit(AuthIdle());
  }

  Future<void> confirmRegistration(String code) async {
    emit(AuthLoading());
    try {
      await _authRepository.confirmRegistration(code);
      emit(AuthSuccess());
    } on Exception catch (e) {
      emit(AuthError(e));
    } finally {
      emit(AuthIdle());
    }
  }

  Future<void> resendConfirmationCode() async {
    emit(AuthLoading());
    try {
      await _authRepository.resendConfirmationCode();
      emit(AuthCodeResended());
    } on Exception catch (e) {
      emit(AuthError(e));
    } finally {
      emit(AuthIdle());
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      await _authRepository.forgotPassword(email);
      emit(AuthSuccess());
    } on Exception catch (e) {
      emit(AuthError(e));
    } finally {
      emit(AuthIdle());
    }
  }

  Future<void> confirmPassword(ForgotPasswordCredentials credentials) async {
    emit(AuthLoading());
    try {
      await _authRepository.confirmPassword(credentials);
      emit(AuthSuccess());
    } on Exception catch (e) {
      emit(AuthError(e));
    } finally {
      emit(AuthIdle());
    }
  }
}

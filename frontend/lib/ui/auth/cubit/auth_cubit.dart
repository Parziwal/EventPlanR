import 'package:bloc/bloc.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_sign_up_not_confirmed_exception.dart';
import 'package:event_planr_app/domain/models/auth/user_forgot_password_credential.dart';
import 'package:event_planr_app/domain/models/auth/user_sign_in_credential.dart';
import 'package:event_planr_app/domain/models/auth/user_sign_up_credential.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.idle());

  final AuthRepository _authRepository;

  Future<void> signIn(UserSignInCredential credential) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.signInUser(credential);
      emit(const AuthState.success());
    } on AuthSignUpNotConfirmedException catch (e) {
      emit(AuthState.error(e.toString()));
      emit(const AuthState.confirmSignUp());
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    } finally {
      emit(const AuthState.idle());
    }
  }

  Future<void> signUp(UserSignUpCredential credential) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.signUpUser(credential);
      emit(const AuthState.confirmSignUp());
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    } finally {
      emit(const AuthState.idle());
    }
  }

  Future<void> autoLogin() async {
    emit(const AuthState.loading());
    try {
      if (await _authRepository.isUserSignedIn()) {
        emit(const AuthState.success());
      }
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    } finally {
      emit(const AuthState.idle());
    }
  }

  Future<void> confirmSignUp(String code) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.confirmSignUp(code);
      emit(const AuthState.signInNext());
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> resendConfirmationCode() async {
    emit(const AuthState.loading());
    try {
      await _authRepository.resendConfirmationCode();
      emit(const AuthState.codeResended());
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    } finally {
      emit(const AuthState.idle());
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.forgotPassword(email);
      emit(const AuthState.confirmForgotPassword());
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    } finally {
      emit(const AuthState.idle());
    }
  }

  Future<void> confirmForgotPassword(
    UserForgotPasswordCredential credential,
  ) async {
    emit(const AuthState.loading());
    try {
      await _authRepository.confirmForgotPassword(credential);
      emit(const AuthState.signInNext());
    } on Exception catch (e) {
      emit(AuthState.error(e.toString()));
    } finally {
      emit(const AuthState.idle());
    }
  }
}

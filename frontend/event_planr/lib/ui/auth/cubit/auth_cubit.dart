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

  Future<void> login(UserLoginCredentials user) async {
    emit(AuthLoading());
    try {
      await _authRepository.loginUser(user);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Error'));
    } finally {
      emit(AuthIdle());
    }
  }

  Future<void> signUp(UserSignUpCredentials user) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUpUser(user);
      emit(AuthConfirm());
    } catch (e) {
      emit(AuthError('Error'));
    } finally {
      emit(AuthIdle());
    }
  }

  Future<void> confirmCode(String code) async {
    emit(AuthLoading());
    try {
      await _authRepository.confirmUser(code);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Error'));
    } finally {
      emit(AuthIdle());
    }
  }
}

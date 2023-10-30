import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_sign_up_not_confirmed_exception.dart';
import 'package:event_planr_app/domain/models/auth/edit_user.dart';
import 'package:event_planr_app/domain/models/auth/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'edit_user_state.dart';

part 'edit_user_cubit.freezed.dart';

@injectable
class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const EditUserState(status: EditUserStatus.idle));

  final AuthRepository _authRepository;

  Future<void> loadUserData() async {
    emit(state.copyWith(status: EditUserStatus.loading));
    final user = await _authRepository.user;
    emit(
      state.copyWith(
        status: EditUserStatus.idle,
        user: user,
      ),
    );
  }

  Future<void> editUser(EditUser user) async {
    try {
      emit(state.copyWith(status: EditUserStatus.loading));
      await _authRepository.editUser(user);
      emit(
        state.copyWith(
          status: EditUserStatus.userEdited,
          emailConfirmationNeeded: false,
        ),
      );
    } on AuthSignUpNotConfirmedException {
      emit(
        state.copyWith(
          status: EditUserStatus.userEdited,
          emailConfirmationNeeded: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: EditUserStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: EditUserStatus.idle));
    await loadUserData();
  }

  Future<void> confirmUserEmail(String confirmCode) async {
    try {
      emit(state.copyWith(status: EditUserStatus.loading));
      await _authRepository.verifyUserEmail(confirmCode);
      emit(state.copyWith(status: EditUserStatus.emailConfirmed));
    } catch (e) {
      emit(
        state.copyWith(
          status: EditUserStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: EditUserStatus.idle));
  }

  Future<void> resendEmailVerificationCode() async {
    try {
      emit(state.copyWith(status: EditUserStatus.loading));
      await _authRepository.resendEmailVerificationCode();
      emit(state.copyWith(status: EditUserStatus.codeResended));
    } catch (e) {
      emit(
        state.copyWith(
          status: EditUserStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: EditUserStatus.idle));
  }
}

import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/chat_repository.dart';
import 'package:event_planr_app/domain/exceptions/auth/auth_sign_up_not_confirmed_exception.dart';
import 'package:event_planr_app/domain/models/auth/edit_user.dart';
import 'package:event_planr_app/domain/models/auth/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'edit_user_state.dart';

part 'edit_user_cubit.freezed.dart';

@injectable
class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
  })  : _authRepository = authRepository,
        _chatRepository = chatRepository,
        super(const EditUserState(status: EditUserStatus.idle));

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;

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
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EditUserStatus.error,
          exception: e,
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
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EditUserStatus.error,
          exception: e,
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
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EditUserStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: EditUserStatus.idle));
  }

  Future<void> uploadProfileImage(XFile image) async {
    if (state.user == null) {
      return;
    }

    try {
      emit(state.copyWith(status: EditUserStatus.loading));
      final imageUrl = await _chatRepository.uploadUserProfileImage(image);
      await _authRepository.refreshToken();
      emit(state.copyWith(user: state.user!.copyWith(picture: imageUrl)));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: EditUserStatus.error,
          exception: e,
        ),
      );
    }

    emit(state.copyWith(status: EditUserStatus.idle));
  }
}

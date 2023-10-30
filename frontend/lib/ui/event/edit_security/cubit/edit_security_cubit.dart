import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/models/auth/change_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'edit_security_state.dart';

part 'edit_security_cubit.freezed.dart';

@injectable
class EditSecurityCubit extends Cubit<EditSecurityState> {
  EditSecurityCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const EditSecurityState(status: EditSecurityStatus.idle));

  final AuthRepository _authRepository;

  Future<void> changeUserPassword(ChangePassword password) async {
    try {
      emit(state.copyWith(status: EditSecurityStatus.loading));
      await _authRepository.changePassword(password);
      emit(state.copyWith(status: EditSecurityStatus.passwordChanged));
    } catch (e) {
      emit(
        state.copyWith(
          status: EditSecurityStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: EditSecurityStatus.idle));
  }
}

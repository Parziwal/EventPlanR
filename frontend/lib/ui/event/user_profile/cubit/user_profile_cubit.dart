import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_profile_state.dart';
part 'user_profile_cubit.freezed.dart';

@injectable
class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit(this._authRepository) : super(const UserProfileState.idle());

  final AuthRepository _authRepository;

  Future<void> logout() async {
    emit(const UserProfileState.loading());
    await _authRepository.signOut();
    emit(const UserProfileState.loggedOut());
    emit(const UserProfileState.idle());
  }
}

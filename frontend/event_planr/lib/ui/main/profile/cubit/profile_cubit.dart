import 'package:equatable/equatable.dart';
import 'package:event_planr/domain/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(ProfileIdle());

  final AuthRepository _authRepository;

  Future<void> logout() async {
    emit(ProfileLoading());
    await _authRepository.signOut();
    emit(ProfileLogoutComplete());
    emit(ProfileIdle());
  }
}

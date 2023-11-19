import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/models/auth/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_navbar_state.dart';

part 'event_navbar_cubit.freezed.dart';

@injectable
class EventNavbarCubit extends Cubit<EventNavbarState> {
  EventNavbarCubit(this._authRepository)
      : super(const EventNavbarState(status: EventNavbarStatus.idle));

  final AuthRepository _authRepository;

  Future<void> loadUserData() async {
    if (await _authRepository.isUserSignedIn) {
      final user = await _authRepository.user;
      emit(state.copyWith(user: user));
    }
  }

  Future<void> logout() async {
    await _authRepository.signOut();
    emit(state.copyWith(status: EventNavbarStatus.loggedOut));
  }
}

import 'package:bloc/bloc.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_navbar_state.dart';

part 'event_navbar_cubit.freezed.dart';

@injectable
class EventNavbarCubit extends Cubit<EventNavbarState> {
  EventNavbarCubit(this._authRepository) : super(const EventNavbarState.idle());

  final AuthRepository _authRepository;

  void changeDesktopTitle(String? title) {
    emit(EventNavbarState.desktopTitleChanged(title ?? ''));
    emit(const EventNavbarState.idle());
  }

  Future<void> logout() async {
    await _authRepository.signOut();
    emit(const EventNavbarState.logout());
    emit(const EventNavbarState.idle());
  }
}

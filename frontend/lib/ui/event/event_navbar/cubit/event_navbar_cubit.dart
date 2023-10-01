import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_navbar_state.dart';

part 'event_navbar_cubit.freezed.dart';

@injectable
class EventNavbarCubit extends Cubit<EventNavbarState> {
  EventNavbarCubit(this._authRepository) : super(const EventNavbarState.idle());

  final AuthRepository _authRepository;
  String desktopTitle = Env.appName;

  Future<void> changeDesktopTitle(String? title) async {
    if (title != null && title.isNotEmpty) {
      desktopTitle = '${Env.appName} - $title';
      emit(const EventNavbarState.desktopTitleChanged());
      emit(const EventNavbarState.idle());
    }
  }

  Future<void> logout() async {
    await _authRepository.signOut();
    emit(const EventNavbarState.loggedOut());
    emit(const EventNavbarState.idle());
  }
}

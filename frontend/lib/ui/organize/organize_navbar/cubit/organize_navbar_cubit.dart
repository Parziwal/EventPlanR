import 'package:event_planr_app/app/app.dart';
import 'package:event_planr_app/data/disk/app_settings.dart';
import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/models/auth/user.dart';
import 'package:event_planr_app/domain/models/event/organization_event.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/organization_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organize_navbar_cubit.freezed.dart';

part 'organize_navbar_state.dart';

@injectable
class OrganizeNavbarCubit extends Cubit<OrganizeNavbarState> {
  OrganizeNavbarCubit({
    required AuthRepository authRepository,
    required OrganizationManagerRepository organizationManagerRepository,
    required AppSettings appSettings,
  })  : _authRepository = authRepository,
        _organizationManagerRepository = organizationManagerRepository,
        _appSettings = appSettings,
        super(const OrganizeNavbarState(status: OrganizeNavbarStatus.idle));

  final AuthRepository _authRepository;
  final OrganizationManagerRepository _organizationManagerRepository;
  final AppSettings _appSettings;

  void changeTitle(String? title) {
    if (title != null) {
      emit(state.copyWith(desktopTitle: title));
    }
  }

  Future<void> loadUserData() async {
    final user = await _authRepository.user;
    final selectedEvent = _appSettings.getOrganizationSelectedEvent();
    emit(state.copyWith(user: user, event: selectedEvent));
    if (user.organizationId != null) {
      await refreshCurrentOrganization();
    }
  }

  Future<void> refreshCurrentOrganization() async {
    try {
      final organization =
          await _organizationManagerRepository.getUserCurrentOrganization();
      emit(state.copyWith(organization: organization));
    } catch (e) {
      emit(
        state.copyWith(
          status: OrganizeNavbarStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> selectEvent(OrganizationEvent event) async {
    emit(state.copyWith(event: event));
    await _appSettings.setOrganizationSelectedEvent(event);
  }

  Future<void> logout() async {
    await _authRepository.signOut();
    emit(state.copyWith(status: OrganizeNavbarStatus.loggedOut));
  }
}

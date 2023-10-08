import 'package:event_planr_app/domain/auth_repository.dart';
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
  })  : _authRepository = authRepository,
        _organizationManagerRepository = organizationManagerRepository,
        super(const OrganizeNavbarState());

  final AuthRepository _authRepository;
  final OrganizationManagerRepository _organizationManagerRepository;

  void changeTitle(String? title) {
    if (title != null) {
      emit(state.copyWith(desktopTitle: title));
    }
  }

  Future<void> refreshCurrentOrganization() async {
    try {
      final organization =
      await _organizationManagerRepository.getUserCurrentOrganization();
      emit(state.copyWith(organization: organization));
    } catch (e) {
      emit(state.copyWith(organization: null));
    }
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }
}

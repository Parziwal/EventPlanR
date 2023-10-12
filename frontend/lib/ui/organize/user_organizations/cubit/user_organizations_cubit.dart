import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/domain/organization_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_organizations_state.dart';

part 'user_organizations_cubit.freezed.dart';

@injectable
class UserOrganizationsCubit extends Cubit<UserOrganizationsState> {
  UserOrganizationsCubit({
    required OrganizationManagerRepository organizationManagerRepository,
    required AuthRepository authRepository,
  })  : _organizationManagerRepository = organizationManagerRepository,
        _authRepository = authRepository,
        super(
          const UserOrganizationsState(
            status: UserOrganizationsStatus.idle,
          ),
        );

  final OrganizationManagerRepository _organizationManagerRepository;
  final AuthRepository _authRepository;

  Future<void> loadUserOrganizations() async {
    try {
      emit(state.copyWith(status: UserOrganizationsStatus.loading));
      final organizations =
          await _organizationManagerRepository.getUserOrganizations();
      emit(
        state.copyWith(
          status: UserOrganizationsStatus.idle,
          organizations: organizations,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserOrganizationsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> setOrganization(String organizationId) async {
    try {
      await _organizationManagerRepository.setUserOrganization(organizationId);
      await _authRepository.refreshToken();
      emit(
        state.copyWith(
          status: UserOrganizationsStatus.organizationChanged,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserOrganizationsStatus.error,
          errorCode: e.toString(),
        ),
      );
    }
  }
}

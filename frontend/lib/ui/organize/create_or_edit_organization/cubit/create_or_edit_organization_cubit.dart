import 'package:event_planr_app/domain/auth_repository.dart';
import 'package:event_planr_app/domain/event_general_repository.dart';
import 'package:event_planr_app/domain/models/organization/create_or_edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:event_planr_app/domain/organization_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'create_or_edit_organization_cubit.freezed.dart';

part 'create_or_edit_organization_state.dart';

@injectable
class CreateOrEditOrganizationCubit
    extends Cubit<CreateOrEditOrganizationState> {
  CreateOrEditOrganizationCubit({
    required OrganizationManagerRepository organizationManagerRepository,
    required EventGeneralRepository eventGeneralRepository,
    required AuthRepository authRepository,
  })  : _organizationManagerRepository = organizationManagerRepository,
        _eventGeneralRepository = eventGeneralRepository,
        _authRepository = authRepository,
        super(
          const CreateOrEditOrganizationState(
            status: CreateOrEditOrganizationStatus.idle,
          ),
        );

  final OrganizationManagerRepository _organizationManagerRepository;
  final EventGeneralRepository _eventGeneralRepository;
  final AuthRepository _authRepository;

  Future<void> loadOrganizationDetailsForEdit() async {
    try {
      emit(
        state.copyWith(
          edit: true,
          status: CreateOrEditOrganizationStatus.loading,
        ),
      );
      final user = await _authRepository.user;
      final organization = await _eventGeneralRepository
          .getOrganizationDetails(user.organizationId!);
      emit(
        state.copyWith(
          status: CreateOrEditOrganizationStatus.idle,
          organizationDetails: organization,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CreateOrEditOrganizationStatus.error,
          exception: e,
        ),
      );
    }
  }

  Future<void> createOrEditOrganization(
    CreateOrEditOrganization organization,
  ) async {
    try {
      emit(state.copyWith(status: CreateOrEditOrganizationStatus.loading));
      await _organizationManagerRepository
          .createOrEditOrganization(organization);
      emit(
        const CreateOrEditOrganizationState(
          status: CreateOrEditOrganizationStatus.organizationSubmitted,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: CreateOrEditOrganizationStatus.error,
          exception: e,
        ),
      );
    }
  }
}

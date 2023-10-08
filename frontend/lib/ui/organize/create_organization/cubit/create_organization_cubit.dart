import 'package:event_planr_app/domain/models/organization/create_organization.dart';
import 'package:event_planr_app/domain/organization_manager_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'create_organization_cubit.freezed.dart';

part 'create_organization_state.dart';

@injectable
class CreateOrganizationCubit extends Cubit<CreateOrganizationState> {
  CreateOrganizationCubit({
    required OrganizationManagerRepository organizationManagerRepository,
  })  : _organizationManagerRepository = organizationManagerRepository,
        super(const CreateOrganizationState.initial());

  final OrganizationManagerRepository _organizationManagerRepository;

  Future<void> createOrganization(CreateOrganization organization) async {
    try {
      emit(const CreateOrganizationState.loading());
      await _organizationManagerRepository.createOrganization(organization);
      emit(const CreateOrganizationState.organizationCreated());
    } catch (e) {
      emit(CreateOrganizationState.error(e.toString()));
    }
  }
}

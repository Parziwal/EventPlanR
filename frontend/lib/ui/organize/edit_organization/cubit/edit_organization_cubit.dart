import 'package:event_planr_app/domain/models/organization/edit_organization.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'edit_organization_cubit.freezed.dart';

part 'edit_organization_state.dart';

@injectable
class EditOrganizationCubit extends Cubit<EditOrganizationState> {
  EditOrganizationCubit() : super(const EditOrganizationState.initial());

  Future<void> loadOrganization(String organizationId) async {
    emit(const EditOrganizationState.loading());
    const organization = OrganizationDetails(
      id: '1',
      name: 'Test',
      description: 'Test',
      profileImageUrl: 'Test',
    );
    emit(
      const EditOrganizationState.organizationDetailsLoaded(
        organization: organization,
        saving: false,
      ),
    );
  }

  Future<void> editOrganization(EditOrganization organization) async {
    if (state case OrganizationDetailsLoaded(:final organization)) {
      emit(
        EditOrganizationState.organizationDetailsLoaded(
          organization: organization,
          saving: true,
        ),
      );
      print(organization);
      emit(const EditOrganizationState.organizationSaved());
    }
  }
}

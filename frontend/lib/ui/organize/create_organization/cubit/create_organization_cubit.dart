import 'package:event_planr_app/domain/models/organization/create_organization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'create_organization_cubit.freezed.dart';
part 'create_organization_state.dart';

@injectable
class CreateOrganizationCubit extends Cubit<CreateOrganizationState> {
  CreateOrganizationCubit() : super(const CreateOrganizationState.initial());

  Future<void> createOrganization(CreateOrganization organization) async {
    emit(const CreateOrganizationState.loading());
    print(organization);
    emit(const CreateOrganizationState.organizationCreated());
  }
}

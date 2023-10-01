part of 'edit_organization_cubit.dart';

@freezed
class EditOrganizationState with _$EditOrganizationState {
  const factory EditOrganizationState.initial() = Initial;
  const factory EditOrganizationState.loading() = Loading;
  const factory EditOrganizationState.organizationDetailsLoaded({
    required OrganizationDetails organization,
    required bool saving,
  }) = OrganizationDetailsLoaded;
  const factory EditOrganizationState.organizationSaved() = OrganizationSaved;
}

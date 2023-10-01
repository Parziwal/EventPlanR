part of 'create_organization_cubit.dart';

@freezed
sealed class CreateOrganizationState with _$CreateOrganizationState {
  const factory CreateOrganizationState.initial() = Initial;
  const factory CreateOrganizationState.loading() = Loading;
  const factory CreateOrganizationState.organizationCreated() =
      OrganizationCreated;
}

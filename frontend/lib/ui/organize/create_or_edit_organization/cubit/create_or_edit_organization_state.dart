part of 'create_or_edit_organization_cubit.dart';

enum CreateOrEditOrganizationStatus {
  idle,
  loading,
  error,
  organizationSubmitted,
}

@freezed
class CreateOrEditOrganizationState with _$CreateOrEditOrganizationState {
  const factory CreateOrEditOrganizationState({
    required CreateOrEditOrganizationStatus status,
    @Default(false) bool edit,
    OrganizationDetails? organizationDetails,
    String? errorCode,
  }) = _CreateOrEditOrganizationState;
}

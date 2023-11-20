part of 'organization_details_cubit.dart';

enum OrganizationDetailsStatus { idle, loading, error }

@freezed
class OrganizationDetailsState with _$OrganizationDetailsState {
  const factory OrganizationDetailsState({
    required OrganizationDetailsStatus status,
    OrganizationDetails? organizationDetails,
    List<Event>? events,
    int? pageNumber,
    Exception? exception,
  }) = _OrganizationDetailsState;
}

part of 'organization_event_news_cubit.dart';

enum OrganizationEventNewsStatus {
  idle,
  error,
  newsCreated,
  newsDeleted,
}

@freezed
class OrganizationEventNewsState with _$OrganizationEventNewsState {
  const factory OrganizationEventNewsState({
    required OrganizationEventNewsStatus status,
    @Default([]) List<OrganizationNewsPost> newsPosts,
    int? pageNumber,
    String? errorCode,
  }) = _OrganizationEventNewsState;
}

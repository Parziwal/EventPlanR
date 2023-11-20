part of 'organization_event_statistics_cubit.dart';

enum OrganizationEventStatisticsStatus { idle, loading, error }

@freezed
class OrganizationEventStatisticsState with _$OrganizationEventStatisticsState {
  const factory OrganizationEventStatisticsState({
    required OrganizationEventStatisticsStatus status,
    EventStatistics? eventStatistics,
    Exception? exception,
  }) = _OrganizationEventStatisticsState;
}

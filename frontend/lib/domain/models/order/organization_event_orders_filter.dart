import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_event_orders_filter.freezed.dart';

@freezed
class OrganizationEventOrdersFilter with _$OrganizationEventOrdersFilter {
  const factory OrganizationEventOrdersFilter({
    required String eventId,
    int? pageNumber,
    int? pageSize,
  }) = _OrganizationEventOrdersFilter;
}

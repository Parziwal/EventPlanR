import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_public_event_filter.freezed.dart';

@freezed
class OrganizationPublicEventFilter with _$OrganizationPublicEventFilter {
  const factory OrganizationPublicEventFilter({
    required String organizationId,
    int? pageNumber,
    int? pageSize,
  }) = _OrganizationPublicEventFilter;
}

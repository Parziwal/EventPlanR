import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_event_filter.freezed.dart';
part 'organization_event_filter.g.dart';

@freezed
class OrganizationEventFilter with _$OrganizationEventFilter {
  const factory OrganizationEventFilter({
    String? searchTerm,
    int? pageNumber,
    int? pageSize,
  }) = _OrganizationEventFilter;

  factory OrganizationEventFilter.fromJson(Map<String, dynamic> json) =>
      _$OrganizationEventFilterFromJson(json);
}

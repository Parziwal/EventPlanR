import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_filter.freezed.dart';

@freezed
class OrganizationFilter with _$OrganizationFilter {
  const factory OrganizationFilter({
    String? searchTerm,
    int? pageNumber,
    int? pageSize,
  }) = _OrganizationFilter;
}

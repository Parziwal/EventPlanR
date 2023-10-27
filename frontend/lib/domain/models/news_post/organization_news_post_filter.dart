import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_news_post_filter.freezed.dart';

@freezed
class OrganizationNewsPostFilter with _$OrganizationNewsPostFilter {
  const factory OrganizationNewsPostFilter({
    required String eventId,
    int? pageNumber,
    int? pageSize,
  }) = _OrganizationNewsPostFilter;
}

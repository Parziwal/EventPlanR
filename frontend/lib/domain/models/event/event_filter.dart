import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_filter.freezed.dart';
part 'event_filter.g.dart';

@freezed
class EventFilter with _$EventFilter {
  const factory EventFilter({
    String? searchTerm,
    int? category,
    int? currency,
    DateTime? fromDate,
    DateTime? toDate,
    double? longitude,
    double? latitude,
    double? radius,
    int? pageNumber,
    int? pageSize,
    String? orderBy,
    int? orderDirection,
  }) = _EventFilter;

  factory EventFilter.fromJson(Map<String, dynamic> json) =>
      _$EventFilterFromJson(json);
}

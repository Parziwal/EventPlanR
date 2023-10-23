import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:event_planr_app/domain/models/event/event_distance_enum.dart';
import 'package:event_planr_app/domain/models/event/event_order_by_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_filter.freezed.dart';
part 'event_filter.g.dart';

@freezed
class EventFilter with _$EventFilter {
  const factory EventFilter({
    required OrderDirectionEnum orderDirection,
    required EventOrderByEnum orderBy,
    String? searchTerm,
    EventCategoryEnum? category,
    CurrencyEnum? currency,
    DateTime? fromDate,
    DateTime? toDate,
    String? locationName,
    double? longitude,
    double? latitude,
    EventDistanceEnum? distance,
    int? pageNumber,
    int? pageSize,
  }) = _EventFilter;

  factory EventFilter.fromJson(Map<String, dynamic> json) =>
      _$EventFilterFromJson(json);
}

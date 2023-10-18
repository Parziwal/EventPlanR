import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_filter.freezed.dart';
part 'event_filter.g.dart';

@freezed
class EventFilter with _$EventFilter {
  const factory EventFilter({
    String? searchTerm,
    EventCategoryEnum? category,
    CurrencyEnum? currency,
    DateTime? fromDate,
    DateTime? toDate,
    double? longitude,
    double? latitude,
    double? radius,
    int? pageNumber,
    int? pageSize,
    String? orderBy,
    OrderDirectionEnum? orderDirection,
  }) = _EventFilter;

  factory EventFilter.fromJson(Map<String, dynamic> json) =>
      _$EventFilterFromJson(json);
}

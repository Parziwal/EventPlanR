import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/common/coordinate.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_or_edit_event.freezed.dart';
part 'create_or_edit_event.g.dart';

@freezed
class CreateOrEditEvent with _$CreateOrEditEvent {
  const factory CreateOrEditEvent({
    required EventCategoryEnum category,
    required DateTime fromDate,
    required DateTime toDate,
    required String venue,
    required Address address,
    required Coordinate coordinates,
    CurrencyEnum? currency,
    bool? isPrivate,
    String? id,
    String? name,
    String? description,
  }) = _CreateOrEditEvent;

  factory CreateOrEditEvent.fromJson(Map<String, Object?> json) =>
      _$CreateOrEditEventFromJson(json);
}

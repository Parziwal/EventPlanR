import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/common/coordinates.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:event_planr_app/domain/models/news_post/news_post.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_details.freezed.dart';

part 'event_details.g.dart';

@freezed
class EventDetails with _$EventDetails {
  const factory EventDetails({
    required String id,
    required String name,
    required String? description,
    required String? coverImageUrl,
    required EventCategoryEnum category,
    required DateTime fromDate,
    required DateTime toDate,
    required String venue,
    required Address address,
    required Coordinates coordinates,
    required Organization organization,
    NewsPost? latestNews,
  }) = _EventDetails;

  factory EventDetails.fromJson(Map<String, Object?> json) =>
      _$EventDetailsFromJson(json);
}

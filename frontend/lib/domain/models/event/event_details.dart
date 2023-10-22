import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:event_planr_app/domain/models/news_post/news_post.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'event_details.freezed.dart';

@freezed
class EventDetails with _$EventDetails {
  const factory EventDetails({
    required String id,
    required String name,
    required EventCategoryEnum category,
    required DateTime fromDate,
    required DateTime toDate,
    required String venue,
    required Address address,
    required LatLng coordinates,
    required Organization organization,
    String? description,
    String? coverImageUrl,
    NewsPost? latestNews,
  }) = _EventDetails;
}

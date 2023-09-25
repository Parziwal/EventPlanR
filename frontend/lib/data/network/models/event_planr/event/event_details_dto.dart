import 'package:event_planr_app/data/network/models/event_planr/common/address_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/common/coordinates_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/news_post/news_post_dto.dart';
import 'package:event_planr_app/data/network/models/event_planr/organization/organization_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_details_dto.freezed.dart';

part 'event_details_dto.g.dart';

@freezed
class EventDetailsDto with _$EventDetailsDto {
  const factory EventDetailsDto({
    required String id,
    required String name,
    required String? description,
    required String? coverImageUrl,
    required int category,
    required DateTime fromDate,
    required DateTime toDate,
    required String venue,
    required AddressDto address,
    required CoordinatesDto coordinates,
    required OrganizationDto organization,
    required NewsPostDto latestNews,
  }) = _EventDetailsDto;

  factory EventDetailsDto.fromJson(Map<String, Object?> json) =>
      _$EventDetailsDtoFromJson(json);
}

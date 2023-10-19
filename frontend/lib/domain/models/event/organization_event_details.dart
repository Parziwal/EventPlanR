import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/common/coordinates.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/event/event_category_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_event_details.freezed.dart';

@freezed
class OrganizationEventDetails with _$OrganizationEventDetails {
  const factory OrganizationEventDetails({
    required String id,
    required String name,
    required EventCategoryEnum category,
    required DateTime fromDate,
    required DateTime toDate,
    required String venue,
    required Address address,
    required Coordinates coordinates,
    required CurrencyEnum currency,
    required bool isPrivate,
    required bool isPublished,
    required DateTime created,
    required DateTime lastModified,
    String? createdBy,
    String? lastModifiedBy,
    String? description,
    String? coverImageUrl,
  }) = _OrganizationEventDetails;
}

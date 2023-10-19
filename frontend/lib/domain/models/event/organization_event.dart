import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_event.freezed.dart';

@freezed
class OrganizationEvent with _$OrganizationEvent {
  const factory OrganizationEvent({
    required String id,
    required String name,
    required DateTime fromDate,
    String? coverImageUrl,
  }) = _OrganizationEvent;
}

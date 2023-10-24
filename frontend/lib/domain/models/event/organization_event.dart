import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization_event.freezed.dart';
part 'organization_event.g.dart';

@freezed
class OrganizationEvent with _$OrganizationEvent {
  const factory OrganizationEvent({
    required String id,
    required String name,
    required DateTime fromDate,
    String? coverImageUrl,
  }) = _OrganizationEvent;

  factory OrganizationEvent.fromJson(Map<String, dynamic> json) =>
      _$OrganizationEventFromJson(json);
}

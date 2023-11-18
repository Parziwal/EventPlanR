import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_invitations_filter.freezed.dart';

@freezed
class EventInvitationsFilter with _$EventInvitationsFilter {
  const factory EventInvitationsFilter({
    required String eventId,
    int? pageNumber,
    int? pageSize,
  }) = _EventInvitationsFilter;
}

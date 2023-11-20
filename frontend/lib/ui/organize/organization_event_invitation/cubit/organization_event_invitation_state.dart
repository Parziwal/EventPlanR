part of 'organization_event_invitation_cubit.dart';

enum OrganizationEventInvitationStatus {
  idle,
  invitationCreated,
  invitationDeleted,
}

@freezed
class OrganizationEventInvitationState with _$OrganizationEventInvitationState {
  const factory OrganizationEventInvitationState({
    required OrganizationEventInvitationStatus status,
    List<EventInvitation>? invitations,
    Exception? exception,
    int? pageNumber,
    String? eventId,
  }) = _OrganizationEventInvitationState;
}

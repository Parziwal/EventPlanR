import 'package:event_planr_app/data/network/event_planr_api/event_invitation/event_invitation_client.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/accept_or_deny_invitation_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/delete_invitation_command.dart';
import 'package:event_planr_app/data/network/event_planr_api/models/invite_user_to_event_command.dart';
import 'package:event_planr_app/domain/models/common/paginated_list.dart';
import 'package:event_planr_app/domain/models/invitation/add_invite_reply.dart';
import 'package:event_planr_app/domain/models/invitation/create_invitation.dart';
import 'package:event_planr_app/domain/models/invitation/event_invitation.dart';
import 'package:event_planr_app/domain/models/invitation/event_invitations_filter.dart';
import 'package:event_planr_app/domain/models/invitation/user_invitation.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:injectable/injectable.dart';

@singleton
class EventInvitationRepository {
  EventInvitationRepository({
    required EventInvitationClient eventInvitationClient,
  }) : _eventInvitationClient = eventInvitationClient;

  final EventInvitationClient _eventInvitationClient;

  Future<PaginatedList<EventInvitation>> getOrganizationEventInvitations(
    EventInvitationsFilter filter,
  ) async {
    final invitations =
        await _eventInvitationClient.getEventinvitationOrganizationevent(
      eventId: filter.eventId,
      pageSize: filter.pageSize,
      pageNumber: filter.pageNumber,
    );

    return PaginatedList(
      items: invitations.items
          .map(
            (i) => EventInvitation(
              id: i.id,
              userFirstName: i.userFirstName,
              userLastName: i.userLastName,
              status: i.status.toDomainEnum(),
              isCheckedIn: i.isCheckedIn,
              created: i.created,
              createdBy: i.createdBy,
            ),
          )
          .toList(),
      pageNumber: invitations.pageNumber,
      totalPages: invitations.totalPages,
      totalCount: invitations.totalCount,
      hasPreviousPage: invitations.hasPreviousPage,
      hasNextPage: invitations.hasNextPage,
    );
  }

  Future<UserInvitation> getUserEventInvitation(
    String eventId,
  ) async {
    final invitation = await _eventInvitationClient
        .getEventinvitationUsereventEventId(eventId: eventId);

    return UserInvitation(
      id: invitation.id,
      eventName: invitation.eventName,
      organizationName: invitation.organizationName,
      status: invitation.status.toDomainEnum(),
      isCheckedIn: invitation.isCheckedIn,
      created: invitation.created,
    );
  }

  Future<void> inviteUserToEvent(
    CreateInvitation invitation,
  ) async {
    await _eventInvitationClient.postEventinvitationOrganizationevent(
      body: InviteUserToEventCommand(
        eventId: invitation.eventId,
        userEmail: invitation.userEmail,
      ),
    );
  }

  Future<void> deleteInvitation(String invitationId) async {
    await _eventInvitationClient.deleteEventinvitationOrganizationevent(
      body: DeleteInvitationCommand(invitationId: invitationId),
    );
  }

  Future<void> acceptOrDenyInvitation(
    AddInviteReply reply,
  ) async {
    await _eventInvitationClient.postEventinvitationUsereventStatus(
      body: AcceptOrDenyInvitationCommand(
        invitationId: reply.invitationId,
        accept: reply.accept,
      ),
    );
  }
}

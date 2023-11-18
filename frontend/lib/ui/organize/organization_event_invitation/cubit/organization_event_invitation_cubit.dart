import 'package:event_planr_app/domain/event_invitation_repository.dart';
import 'package:event_planr_app/domain/models/invitation/create_invitation.dart';
import 'package:event_planr_app/domain/models/invitation/event_invitation.dart';
import 'package:event_planr_app/domain/models/invitation/event_invitations_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'organization_event_invitation_state.dart';

part 'organization_event_invitation_cubit.freezed.dart';

@injectable
class OrganizationEventInvitationCubit
    extends Cubit<OrganizationEventInvitationState> {
  OrganizationEventInvitationCubit({
    required EventInvitationRepository eventInvitationRepository,
  })  : _eventInvitationRepository = eventInvitationRepository,
        super(
          const OrganizationEventInvitationState(
            status: OrganizationEventInvitationStatus.idle,
          ),
        );

  final EventInvitationRepository _eventInvitationRepository;

  Future<void> getEventInvitations({
    required int pageNumber,
    String? eventId,
  }) async {
    if (eventId == null && state.eventId == null) {
      return;
    }

    try {
      emit(
        state.copyWith(
          invitations: pageNumber == 1 ? null : state.invitations,
          eventId: eventId ?? state.eventId,
        ),
      );
      final tickets =
          await _eventInvitationRepository.getOrganizationEventInvitations(
        EventInvitationsFilter(
          eventId: state.eventId!,
          pageNumber: pageNumber,
          pageSize: 20,
        ),
      );
      emit(
        state.copyWith(
          invitations: pageNumber == 1
              ? tickets.items
              : [...state.invitations!, ...tickets.items],
          pageNumber: tickets.hasNextPage ? pageNumber + 1 : null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCode: e.toString(),
        ),
      );
    }
  }

  Future<void> createInvitation(String userEmail) async {
    if (state.eventId == null) {
      return;
    }

    try {
      await _eventInvitationRepository.inviteUserToEvent(
        CreateInvitation(
          eventId: state.eventId!,
          userEmail: userEmail,
        ),
      );
      emit(
        state.copyWith(
          status: OrganizationEventInvitationStatus.invitationCreated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCode: e.toString(),
        ),
      );
    }

    emit(
      state.copyWith(
        status: OrganizationEventInvitationStatus.idle,
      ),
    );

    await getEventInvitations(pageNumber: 1);
  }

  Future<void> deleteInvitation(String invitationId) async {
    try {
      await _eventInvitationRepository.deleteInvitation(invitationId);
      emit(
        state.copyWith(
          status: OrganizationEventInvitationStatus.invitationDeleted,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorCode: e.toString(),
        ),
      );
    }

    emit(
      state.copyWith(
        status: OrganizationEventInvitationStatus.idle,
      ),
    );
    await getEventInvitations(pageNumber: 1);
  }
}

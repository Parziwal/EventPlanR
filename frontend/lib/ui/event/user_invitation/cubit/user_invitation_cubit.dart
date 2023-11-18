import 'package:event_planr_app/domain/event_invitation_repository.dart';
import 'package:event_planr_app/domain/models/invitation/add_invite_reply.dart';
import 'package:event_planr_app/domain/models/invitation/invitation_status_enum.dart';
import 'package:event_planr_app/domain/models/invitation/user_invitation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_invitation_state.dart';

part 'user_invitation_cubit.freezed.dart';

@injectable
class UserInvitationCubit extends Cubit<UserInvitationState> {
  UserInvitationCubit({
    required EventInvitationRepository eventInvitationRepository,
  })  : _eventInvitationRepository = eventInvitationRepository,
        super(const UserInvitationState(status: UserInvitationStatus.idle));

  final EventInvitationRepository _eventInvitationRepository;

  Future<void> loadInvitation(String eventId) async {
    try {
      emit(state.copyWith(status: UserInvitationStatus.loading));
      final invitation =
          await _eventInvitationRepository.getUserEventInvitation(eventId);
      emit(state.copyWith(invitation: invitation));
    } catch (e) {
      emit(
        state.copyWith(
          status: UserInvitationStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: UserInvitationStatus.idle));
  }

  Future<void> changeInvitationStatus({
    required String invitationId,
    required bool accept,
  }) async {
    try {
      emit(state.copyWith(status: UserInvitationStatus.loading));
      await _eventInvitationRepository.acceptOrDenyInvitation(
        AddInviteReply(
          invitationId: invitationId,
          accept: accept,
        ),
      );
      emit(
        state.copyWith(
          status: accept
              ? UserInvitationStatus.invitationAccepted
              : UserInvitationStatus.invitationDenied,
          invitation: state.invitation?.copyWith(
            status: accept
                ? InvitationStatusEnum.accept
                : InvitationStatusEnum.deny,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: UserInvitationStatus.error,
          errorCode: e.toString(),
        ),
      );
    }

    emit(state.copyWith(status: UserInvitationStatus.idle));
  }
}

import 'package:event_planr_app/domain/models/invitation/invitation_status_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_invitation.freezed.dart';

@freezed
class UserInvitation with _$UserInvitation {
  const factory UserInvitation({
    required String id,
    required String eventName,
    required String organizationName,
    required InvitationStatusEnum status,
    required bool isCheckedIn,
    required DateTime created,
    String? ticketId,
  }) = _UserInvitation;
}

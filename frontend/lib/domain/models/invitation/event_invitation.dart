import 'package:event_planr_app/domain/models/invitation/invitation_status_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_invitation.freezed.dart';

@freezed
class EventInvitation with _$EventInvitation {
  const factory EventInvitation({
    required String id,
    required String userFirstName,
    required String userLastName,
    required InvitationStatusEnum status,
    required bool isCheckedIn,
    required DateTime created,
    required String createdBy,
  }) = _EventInvitation;

  const EventInvitation._();

  String getUserFullName(BuildContext context) {
    return context.l10n.localeName == 'hu'
        ? '$userLastName $userFirstName'
        : '$userFirstName $userLastName';
  }

}

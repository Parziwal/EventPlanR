import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_ticket.freezed.dart';

@freezed
class CheckInTicket with _$CheckInTicket {
  const factory CheckInTicket({
    required String id,
    required String userFirstName,
    required String userLastName,
    required String ticketName,
    required bool isCheckedIn,
  }) = _CheckInTicket;

  const CheckInTicket._();

  String getUserFullName(BuildContext context) {
    return context.l10n.localeName == 'hu'
        ? '$userLastName $userFirstName'
        : '$userFirstName $userLastName';
  }
}

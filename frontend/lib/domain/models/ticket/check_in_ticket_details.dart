import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_in_ticket_details.freezed.dart';

@freezed
class CheckInTicketDetails with _$CheckInTicketDetails {
  const factory CheckInTicketDetails({
    required String id,
    required String userFirstName,
    required String userLastName,
    required String ticketName,
    required bool isCheckedIn,
    required double price,
    required CurrencyEnum currency,
    required String orderId,
    required DateTime created,
  }) = _CheckInTicketDetails;

  const CheckInTicketDetails._();

  String getUserFullName(BuildContext context) {
    return context.l10n.localeName == 'hu'
        ? '$userLastName $userFirstName'
        : '$userFirstName $userLastName';
  }
}

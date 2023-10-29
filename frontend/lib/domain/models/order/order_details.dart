import 'package:event_planr_app/domain/models/common/address.dart';
import 'package:event_planr_app/domain/models/event/currency_enum.dart';
import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_details.freezed.dart';

@freezed
class OrderDetails with _$OrderDetails {
  const factory OrderDetails({
    required String id,
    required String customerFirstName,
    required String customerLastName,
    required Address billingAddress,
    required double total,
    required CurrencyEnum currency,
    required List<SoldTicket> soldTickets,
    required DateTime created,
  }) = _OrderDetails;

  const OrderDetails._();

  String getUserFullName(BuildContext context) {
    return context.l10n.localeName == 'hu'
        ? '$customerLastName $customerFirstName'
        : '$customerFirstName $customerLastName';
  }
}

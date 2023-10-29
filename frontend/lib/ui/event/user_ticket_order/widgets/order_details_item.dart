import 'package:event_planr_app/domain/models/order/order_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/shared/widgets/label.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailsItem extends StatelessWidget {
  const OrderDetailsItem({required this.orderDetails, super.key});

  final OrderDetails orderDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Label(
              label: '#${orderDetails.id}',
              value: '${l10n.userTicketOrder_Created}: '
                  '${DateFormat.yMd().format(orderDetails.created)}',
              textStyle: theme.textTheme.titleMedium,
            ),
            Label(
              label: l10n.userTicketOrder_CustomerName,
              value: orderDetails.getUserFullName(context),
              textStyle: theme.textTheme.titleMedium,
            ),
            const Divider(),
            Text(
              l10n.userTicketOrder_BillingAddress,
              style: theme.textTheme.titleMedium,
            ),
            Label(
              label: l10n.userTicketOrder_Country,
              value: orderDetails.billingAddress.country,
            ),
            Label(
              label: l10n.userTicketOrder_ZipCode,
              value: orderDetails.billingAddress.zipCode,
            ),
            Label(
              label: l10n.userTicketOrder_City,
              value: orderDetails.billingAddress.city,
            ),
            Label(
              label: l10n.userTicketOrder_AddressLine,
              value: orderDetails.billingAddress.addressLine,
            ),
            const Divider(),
            Text(
              l10n.userTicketOrder_Tickets,
              style: theme.textTheme.titleMedium,
            ),
            ...orderDetails.soldTickets.map(
              (t) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(
                    label: t.ticketName,
                    value: '${t.price} ${l10n.translateEnums(
                      t.currency.name,
                    )}',
                  ),
                  Text('${l10n.userTicketOrder_Username}: '
                      '${t.getUserFullName(context)}'),
                  const Divider(),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Label(
              label: l10n.userTicketOrder_Total,
              value: '${orderDetails.total} '
                  '${l10n.translateEnums(orderDetails.currency.name)}',
              textStyle: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

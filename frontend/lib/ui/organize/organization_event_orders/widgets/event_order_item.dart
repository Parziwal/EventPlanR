import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/order/event_order.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/shared/widgets/label.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/domain_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventOrderItem extends StatelessWidget {
  const EventOrderItem({required this.eventOrder, super.key});

  final EventOrder eventOrder;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final eventId = context.goRouterState.pathParameters['eventId']!;

    return InkWell(
      onTap: () => context.go(
        PagePaths.organizationEventOrderDetails(eventId, eventOrder.id),
      ),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventOrder.getUserFullName(context),
                style: theme.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(),
              Label(
                label: l10n.organizationEventOrders_Tickets,
                value: eventOrder.ticketCount.toString(),
              ),
              Label(
                label: l10n.organizationEventOrders_Total,
                value: '${eventOrder.total} '
                    '${l10n.translateEnums(eventOrder.currency.name)}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

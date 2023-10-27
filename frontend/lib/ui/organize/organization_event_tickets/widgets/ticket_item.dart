import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/organize/organization_event_tickets/cubit/organization_event_tickets_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/confirmation_dialog.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({required this.ticket, super.key});

  final OrganizationTicket ticket;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final goRouterState = context.goRouterState;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ticket.name, style: theme.textTheme.titleLarge),
                const SizedBox(height: 16),
                Text(
                  '${l10n.organizationEventTickets_Total} '
                  '${ticket.remainingCount} / ${ticket.count}',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text('${l10n.organizationEventTickets_Price} '
                    '${ticket.price} '
                    '${l10n.translateEnums(ticket.currency.name)}'),
                const SizedBox(height: 16),
                Text('${l10n.organizationEventTickets_SaleStarts} '
                    '${formatDateTime(ticket.saleStarts)}'),
                Text('${l10n.organizationEventTickets_SaleEnds} '
                    '${formatDateTime(ticket.saleEnds)}'),
                const SizedBox(height: 16),
                Text('${l10n.organizationEventTickets_Description} '
                    '${ticket.description ?? '-'}'),
                const SizedBox(height: 16),
                Text(
                  '${l10n.organizationEventTickets_Created} '
                  '${ticket.createdBy ?? '-'}, '
                  '${formatDateTime(ticket.created)}',
                  style: theme.textTheme.labelMedium,
                ),
                Text(
                  '${l10n.organizationEventTickets_LastModified} '
                  '${ticket.lastModifiedBy ?? '-'}, '
                  '${formatDateTime(ticket.lastModified)}',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.go(
                      PagePaths.organizationEventTicketEdit(
                        goRouterState.pathParameters['eventId']!,
                      ),
                      extra: ticket,
                    ),
                    icon: const Icon(Icons.edit),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _deleteTicket(context),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTicket(BuildContext context) {
    final l10n = context.l10n;

    showConfirmationDialog(
      context,
      message: l10n.organizationEventTickets_AreYouSureYouWantToDeleteTicket(
        ticket.name,
      ),
    ).then((value) {
      if (value ?? false) {
        context.read<OrganizationEventTicketsCubit>().deleteTicket(ticket.id);
      }
    });
  }
}

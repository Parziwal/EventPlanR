import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/ticket/check_in_ticket.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in/cubit/organization_event_check_in_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckInTicketItem extends StatelessWidget {
  const CheckInTicketItem({required this.checkInTicket, super.key});

  final CheckInTicket checkInTicket;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final eventId = context.goRouterState.pathParameters['eventId']!;

    return InkWell(
      onTap: () => context.go(
        PagePaths.organizationEventCheckInDetails(eventId, checkInTicket.id),
      ),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Container(
              color: checkInTicket.isCheckedIn
                  ? theme.colorScheme.tertiary
                  : Colors.transparent,
              width: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      checkInTicket.getUserFullName(context),
                      style: theme.textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Divider(),
                    Text(
                      checkInTicket.ticketName,
                      style: theme.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => context.read<OrganizationEventCheckInCubit>()
                  .ticketCheckIn(checkInTicket.id),
              icon: checkInTicket.isCheckedIn
                  ? const Icon(Icons.output)
                  : const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}

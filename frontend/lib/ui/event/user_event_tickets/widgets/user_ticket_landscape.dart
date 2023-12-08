import 'package:event_planr_app/domain/models/ticket/sold_ticket.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class UserTicketLandscape extends StatelessWidget {
  const UserTicketLandscape({required this.ticket, super.key});

  final SoldTicket ticket;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SizedBox(
      height: 200,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              PrettyQrView.data(
                data: ticket.id,
                decoration: PrettyQrDecoration(
                  shape: PrettyQrRoundedSymbol(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.ticketName,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      ticket.getUserFullName(context),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

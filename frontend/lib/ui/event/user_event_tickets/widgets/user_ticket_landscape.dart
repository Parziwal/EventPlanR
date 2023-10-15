import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class UserTicketLandscape extends StatelessWidget {
  const UserTicketLandscape({super.key});

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
                data: 'ticket.id',
                decoration: PrettyQrDecoration(
                  image: const PrettyQrDecorationImage(
                    image: AssetImage('assets/icon/icon.png'),
                  ),
                  shape: PrettyQrRoundedSymbol(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ticket name',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'User name',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

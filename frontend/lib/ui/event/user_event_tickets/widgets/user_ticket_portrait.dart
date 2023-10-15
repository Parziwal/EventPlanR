import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class UserTicketPortrait extends StatelessWidget {
  const UserTicketPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ticket name',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            AspectRatio(
              aspectRatio: 1,
              child: PrettyQrView.data(
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
            ),
            const SizedBox(height: 16),
            Text(
              'User name',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

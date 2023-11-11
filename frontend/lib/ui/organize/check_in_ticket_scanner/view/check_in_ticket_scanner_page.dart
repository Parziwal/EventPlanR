import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/check_in_ticket_scanner/cubit/check_in_ticket_scanner_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckInTicketScannerPage extends StatelessWidget {
  const CheckInTicketScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: l10n.checkInTicketScanner,
      body: BlocListener<CheckInTicketScannerCubit, CheckInTicketScannerState>(
        listener: _stateListener,
        child: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
          ),
          onDetect: (capture) {
            if (capture.barcodes.length == 1 &&
                capture.barcodes.single.type == BarcodeType.text &&
                capture.barcodes.single.rawValue != null) {
              context
                  .read<CheckInTicketScannerCubit>()
                  .ticketCheckIn(capture.barcodes.single.rawValue!);
            }
          },
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    CheckInTicketScannerState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == CheckInTicketScannerStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.errorCode!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    } else if (state.status == CheckInTicketScannerStatus.ticketChecked) {
      final eventId = context.goRouterState.pathParameters['eventId']!;
      final ticket = state.checkedTicket!;
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: ListTile(
              title: Text(
                ticket.getUserFullName(context),
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.onTertiary),
              ),
              subtitle: Text(
                ticket.ticketName,
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: theme.colorScheme.onTertiary),
              ),
              trailing: IconButton(
                onPressed: () => context.go(
                  PagePaths.organizationEventCheckInDetails(
                    eventId,
                    ticket.id,
                  ),
                ),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: theme.colorScheme.onTertiary,
                ),
              ),
            ),
            backgroundColor: theme.colorScheme.tertiary,
          ),
        );
    }
  }
}

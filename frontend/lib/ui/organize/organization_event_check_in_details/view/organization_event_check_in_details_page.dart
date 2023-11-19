import 'package:event_planr_app/domain/models/ticket/check_in_ticket_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in_details/cubit/organization_event_check_in_details_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/label.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/max_width_box.dart';

class OrganizationEventCheckInDetailsPage extends StatelessWidget {
  const OrganizationEventCheckInDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final checkedIn = context
            .watch<OrganizationEventCheckInDetailsCubit>()
            .state
            .checkInTicketDetails
            ?.isCheckedIn ??
        false;

    return OrganizeScaffold(
      title: l10n.organizationEventCheckInDetails,
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => context
            .read<OrganizationEventCheckInDetailsCubit>()
            .ticketCheckIn(),
        child: Icon(
          checkedIn ? Icons.output : Icons.exit_to_app,
        ),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => context
              .read<OrganizationEventCheckInDetailsCubit>()
              .ticketCheckIn(),
          icon: Icon(
            checkedIn ? Icons.output : Icons.exit_to_app,
          ),
          label: Text(
            checkedIn
                ? l10n.organizationEventCheckInDetails_CheckOut
                : l10n.organizationEventCheckInDetails_CheckIn,
          ),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body: BlocConsumer<OrganizationEventCheckInDetailsCubit,
          OrganizationEventCheckInDetailsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == OrganizationEventCheckInDetailsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.checkInTicketDetails != null) {
            return _mainContent(context, state.checkInTicketDetails!);
          }

          return Container();
        },
      ),
    );
  }

  Widget _mainContent(BuildContext context, CheckInTicketDetails ticket) {
    final l10n = context.l10n;
    final theme = context.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: MaxWidthBox(
        maxWidth: 1000,
        child: Column(
          children: [
            Label(
              label: l10n.organizationEventCheckInDetails_Username,
              value: ticket.getUserFullName(context),
              textStyle: theme.textTheme.titleLarge,
            ),
            const Divider(),
            Container(
              color: ticket.isCheckedIn
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
              width: double.infinity,
              child: Center(
                child: Text(
                  ticket.isCheckedIn
                      ? l10n.organizationEventCheckInDetails_CheckedIn
                      : l10n.organizationEventCheckInDetails_NotCheckedIn,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: ticket.isCheckedIn
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(),
            Label(
              label: l10n.organizationEventCheckInDetails_Ticket,
              value: ticket.ticketName,
              textStyle: theme.textTheme.titleMedium,
            ),
            Label(
              label: l10n.organizationEventCheckInDetails_OrderNumber,
              value: ticket.orderId,
              textStyle: theme.textTheme.titleMedium,
            ),
            Label(
              label: l10n.organizationEventCheckInDetails_Date,
              value: DateFormat.yMd(l10n.localeName).format(ticket.created),
              textStyle: theme.textTheme.titleMedium,
            ),
            Label(
              label: l10n.organizationEventCheckInDetails_Price,
              value: '${ticket.price} '
                  '${l10n.translateEnums(ticket.currency.name)}',
              textStyle: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationEventCheckInDetailsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationEventCheckInDetailsStatus.error) {
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
    } else if (state.status ==
        OrganizationEventCheckInDetailsStatus.checkedInChanged) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.checkInTicketDetails!.isCheckedIn
                  ? l10n.organizationEventCheckInDetails_UserCheckedIn
                  : l10n.organizationEventCheckInDetails_UserCheckedOut,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }
}

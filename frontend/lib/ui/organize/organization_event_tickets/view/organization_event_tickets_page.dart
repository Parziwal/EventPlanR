import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/organization/organization_policy.dart';
import 'package:event_planr_app/domain/models/ticket/organization_ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/organization_event_tickets/cubit/organization_event_tickets_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_tickets/widgets/ticket_item.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationEventTicketsPage extends StatelessWidget {
  const OrganizationEventTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final goRouterState = context.goRouterState;
    final user = context.watch<OrganizeNavbarCubit>().state.user;

    return OrganizeScaffold(
      title: l10n.organizationEventTickets,
      showActions: user != null &&
          user.organizationPolicies
              .contains(OrganizationPolicy.eventTicketManage),
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => context.go(
          PagePaths.organizationEventTicketCreate(
            goRouterState.pathParameters['eventId']!,
          ),
        ),
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => context.go(
            PagePaths.organizationEventTicketCreate(
              goRouterState.pathParameters['eventId']!,
            ),
          ),
          icon: const Icon(Icons.add),
          label: Text(l10n.organizationEventTickets_AddTicket),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body: BlocConsumer<OrganizationEventTicketsCubit,
          OrganizationEventTicketsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == OrganizationEventTicketsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.tickets != null) {
            return _mainContent(state.tickets!);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationEventTicketsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationEventTicketsStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.exception!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    }
  }

  Widget _mainContent(List<OrganizationTicket> tickets) {
    return Center(
      child: MaxWidthBox(
        maxWidth: 1000,
        child: ListView.builder(
          itemCount: tickets.length,
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          itemBuilder: (context, i) {
            return TicketItem(ticket: tickets[i]);
          },
        ),
      ),
    );
  }
}

import 'package:event_planr_app/domain/models/event/event_statistics.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/organize/organization_event_statistics/cubit/organization_event_statistics_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_statistics/widgets/check_in_ticket_diagram.dart';
import 'package:event_planr_app/ui/organize/organization_event_statistics/widgets/percentage_data_item.dart';
import 'package:event_planr_app/ui/organize/organization_event_statistics/widgets/sold_ticket_diagram.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/label.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/max_width_box.dart';

class OrganizationEventStatisticsPage extends StatefulWidget {
  const OrganizationEventStatisticsPage({super.key});

  @override
  State<OrganizationEventStatisticsPage> createState() =>
      _OrganizationEventStatisticsPageState();
}

class _OrganizationEventStatisticsPageState
    extends State<OrganizationEventStatisticsPage> {
  bool _soldTicketsPerMonth = false;
  bool _checkInsPerDay = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: l10n.eventStatistics,
      body: BlocConsumer<OrganizationEventStatisticsCubit,
          OrganizationEventStatisticsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == OrganizationEventStatisticsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.eventStatistics != null) {
            return _mainContent(context, state.eventStatistics!);
          }

          return Container();
        },
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationEventStatisticsState state,
  ) {}

  Widget _mainContent(BuildContext context, EventStatistics eventStatistics) {
    final l10n = context.l10n;
    final theme = context.theme;

    return MaxWidthBox(
      maxWidth: 800,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Label(
              label: l10n.eventStatistics_TotalIncome,
              value: '${eventStatistics.totalIncome} '
                  '${l10n.translateEnums(eventStatistics.currency.name)}',
              textStyle: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _soldTicketStatistics(context, eventStatistics),
            const SizedBox(height: 8),
            _checkInStatistics(context, eventStatistics),
            const SizedBox(height: 16),
            _invitationStatistics(context, eventStatistics),
          ],
        ),
      ),
    );
  }

  Widget _soldTicketStatistics(
    BuildContext context,
    EventStatistics eventStatistics,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Column(
      children: [
        Stack(
          children: [
            SoldTicketDiagram(
              chartSpots: _soldTicketsPerMonth
                  ? eventStatistics.soldTicketsPerMonth
                  : eventStatistics.soldTicketsPerDay,
              perMonth: _soldTicketsPerMonth,
            ),
            Positioned(
              child: FilledButton(
                onPressed: () {
                  setState(() {
                    _soldTicketsPerMonth = !_soldTicketsPerMonth;
                  });
                },
                child: Text(
                  _soldTicketsPerMonth
                      ? l10n.eventStatistics_PerDay
                      : l10n.eventStatistics_PerMonth,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          l10n.eventStatistics_SoldTicketsTotalAvailable,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: PercentageDataItem(
            totalCount: eventStatistics.totalTicketCount,
            count: eventStatistics.soldTicketCount,
            name: l10n.eventStatistics_TicketsSold,
            progressSize: 70,
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        ...eventStatistics.ticketStatistics.map(
          (t) => Padding(
            padding: const EdgeInsets.only(left: 48, bottom: 16),
            child: PercentageDataItem(
              totalCount: t.totalTicketCount,
              count: t.soldTicketCount,
              name: t.ticketName,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _checkInStatistics(
    BuildContext context,
    EventStatistics eventStatistics,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Column(
      children: [
        Stack(
          children: [
            CheckInTicketDiagram(
              chartSpots: _checkInsPerDay
                  ? eventStatistics.checkInsPerDay
                  : eventStatistics.checkInsPerHour,
              perDay: _checkInsPerDay,
            ),
            Positioned(
              child: FilledButton(
                onPressed: () {
                  setState(() {
                    _checkInsPerDay = !_checkInsPerDay;
                  });
                },
                child: Text(
                  _checkInsPerDay
                      ? l10n.eventStatistics_PerHour
                      : l10n.eventStatistics_PerDay,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          l10n.eventStatistics_CheckedInTicketsTotalAvailable,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: PercentageDataItem(
            totalCount: eventStatistics.totalTicketCount,
            count: eventStatistics.totalCheckInCount,
            name: l10n.eventStatistics_TicketsCheckedIn,
            progressSize: 70,
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        ...eventStatistics.ticketStatistics.map(
          (t) => Padding(
            padding: const EdgeInsets.only(left: 48, bottom: 16),
            child: PercentageDataItem(
              totalCount: t.totalTicketCount,
              count: t.checkedInTicketCount,
              name: t.ticketName,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _invitationStatistics(
    BuildContext context,
    EventStatistics eventStatistics,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Column(
      children: [
        Text(
          l10n.eventStatistics_Invitations,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: PercentageDataItem(
            totalCount: eventStatistics.totalInvitationCount,
            count: eventStatistics.acceptedInvitationCount,
            name: l10n.eventStatistics_AcceptedInvitations,
            progressSize: 70,
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: PercentageDataItem(
            totalCount: eventStatistics.totalInvitationCount,
            count: eventStatistics.deniedInvitationCount,
            name: l10n.eventStatistics_DeniedInvitations,
            progressSize: 70,
            style: theme.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: PercentageDataItem(
            totalCount: eventStatistics.totalInvitationCount,
            count: eventStatistics.pendingInvitationCount,
            name: l10n.eventStatistics_PendingInvitations,
            progressSize: 70,
            style: theme.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

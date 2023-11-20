import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/ticket/check_in_ticket.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in/cubit/organization_event_check_in_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_check_in/widgets/check_in_ticket_item.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationEventCheckInPage extends StatefulWidget {
  const OrganizationEventCheckInPage({super.key});

  @override
  State<OrganizationEventCheckInPage> createState() =>
      _OrganizationEventCheckInPageState();
}

class _OrganizationEventCheckInPageState
    extends State<OrganizationEventCheckInPage> {
  final PagingController<int, CheckInTicket> _pagingController =
      PagingController(firstPageKey: 1);
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) {
      return;
    }
    initialized = true;

    final eventId = context.goRouterState.pathParameters['eventId']!;
    _pagingController.addPageRequestListener(
      (pageKey) => context
          .read<OrganizationEventCheckInCubit>()
          .getCheckInTickets(eventId: eventId, pageNumber: pageKey),
    );

    context.watch<OrganizationEventCheckInCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.exception,
        itemList: state.soldTickets,
      );
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final eventId = context.goRouterState.pathParameters['eventId']!;

    return OrganizeScaffold(
      title: l10n.organizationEventCheckIn,
      mobileFloatingButton: FloatingActionButton(
        onPressed: () =>
            context.go(PagePaths.organizationEventCheckInScanner(eventId)),
        child: const Icon(Icons.qr_code_scanner),
      ),
      body: MaxWidthBox(
        maxWidth: 1000,
        child: PagedGridView(
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisExtent: 100,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
          builderDelegate: PagedChildBuilderDelegate<CheckInTicket>(
            itemBuilder: (context, item, index) =>
                CheckInTicketItem(checkInTicket: item),
          ),
        ),
      ),
    );
  }
}

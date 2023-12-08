import 'package:event_planr_app/domain/models/order/event_order.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_event_orders/cubit/organization_event_orders_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_orders/widgets/event_order_item.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationEventOrdersPage extends StatefulWidget {
  const OrganizationEventOrdersPage({super.key});

  @override
  State<OrganizationEventOrdersPage> createState() =>
      _OrganizationEventOrdersPageState();
}

class _OrganizationEventOrdersPageState
    extends State<OrganizationEventOrdersPage> {
  final PagingController<int, EventOrder> _pagingController =
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
          .read<OrganizationEventOrdersCubit>()
          .getEventOrders(eventId: eventId, pageNumber: pageKey),
    );

    context.watch<OrganizationEventOrdersCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.exception,
        itemList: state.eventOrders,
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

    return OrganizeScaffold(
      title: l10n.organizationEventOrders,
      body: MaxWidthBox(
        maxWidth: 1000,
        child: PagedGridView(
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            mainAxisExtent: 110,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          builderDelegate: PagedChildBuilderDelegate<EventOrder>(
            itemBuilder: (context, item, index) =>
                EventOrderItem(eventOrder: item),
          ),
        ),
      ),
    );
  }
}

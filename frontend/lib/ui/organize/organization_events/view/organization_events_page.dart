import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/event/organization_event.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_events/cubit/organization_events_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_events/widgets/organization_event_item.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/max_width_box.dart';

class OrganizationEventsPage extends StatefulWidget {
  const OrganizationEventsPage({super.key});

  @override
  State<OrganizationEventsPage> createState() => _OrganizationEventsPageState();
}

class _OrganizationEventsPageState extends State<OrganizationEventsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final PagingController<int, OrganizationEvent> _pagingController =
      PagingController(firstPageKey: 1);
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) {
      return;
    }
    initialized = true;

    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    _pagingController.addPageRequestListener(_loadOrganizationEvents);

    context.watch<OrganizationEventsCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.errorCode,
        itemList: state.events,
      );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return OrganizeScaffold(
      title: l10n.organizationEvents,
      tabBar: TabBar(
        controller: _tabController,
        onTap: (int index) {
          _tabController.animateTo(index);
          _pagingController.notifyPageRequestListeners(1);
        },
        tabs: [
          Tab(text: l10n.organizationEvents_Upcoming),
          Tab(text: l10n.organizationEvents_Draft),
          Tab(text: l10n.organizationEvents_Past),
        ],
      ),
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => context.go(PagePaths.organizationEventsCreate),
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => context.go(
            PagePaths.organizationEventsCreate,
          ),
          icon: const Icon(Icons.add),
          label: Text(l10n.organizationEvents_AddEvent),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body: MaxWidthBox(
        maxWidth: 1000,
        child: PagedGridView<int, OrganizationEvent>(
          showNoMoreItemsIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 700,
            mainAxisExtent: 100,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          padding: const EdgeInsets.only(top: 8, left: 32, right: 32),
          builderDelegate: PagedChildBuilderDelegate<OrganizationEvent>(
            itemBuilder: (context, item, index) => OrganizationEventItem(
              event: item,
            ),
          ),
        ),
      ),
    );
  }

  void _loadOrganizationEvents(int pageNumber) {
    switch (_tabController.index) {
      case 0:
        context
            .read<OrganizationEventsCubit>()
            .getOrganizationUpcomingEvents(pageNumber);
      case 1:
        context
            .read<OrganizationEventsCubit>()
            .getOrganizationDraftEvents(pageNumber);
      case 2:
        context
            .read<OrganizationEventsCubit>()
            .getOrganizationPastEvents(pageNumber);
    }
  }
}

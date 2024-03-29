import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_events/cubit/user_events_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_landscape.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_portrait.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UserEventsPage extends StatefulWidget {
  const UserEventsPage({super.key});

  @override
  State<UserEventsPage> createState() => _UserEventsPageState();
}

class _UserEventsPageState extends State<UserEventsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final PagingController<int, Event> _pagingController =
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

    _pagingController.addPageRequestListener(_loadUserEvents);

    context.watch<UserEventsCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.exception,
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
    final breakpoints = context.breakpoints;

    return EventScaffold(
      title: l10n.userEvents,
      tabBar: TabBar(
        controller: _tabController,
        onTap: (int index) {
          setState(() {
            _tabController.animateTo(index);
            _pagingController.notifyPageRequestListeners(1);
          });
        },
        tabs: [
          Tab(text: l10n.userEvents_Upcoming),
          Tab(text: l10n.userEvents_Invitation),
          Tab(text: l10n.userEvents_Past),
        ],
      ),
      body: PagedGridView<int, Event>(
        pagingController: _pagingController,
        showNoMoreItemsIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: breakpoints.isMobile ? 500 : 400,
          crossAxisSpacing: 16,
          mainAxisExtent: breakpoints.isMobile ? 120 : null,
        ),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
        ),
        builderDelegate: PagedChildBuilderDelegate<Event>(
          itemBuilder: (context, item, index) {
            return breakpoints.isMobile
                ? FittedBox(
                  child: EventItemCardLandscape(
                      onPressed: () => _eventItemPressed(item),
                      event: item,
                    ),
                )
                : FittedBox(
                    child: EventItemCardPortrait(
                      onPressed: () => _eventItemPressed(item),
                      event: item,
                    ),
                  );
          },
        ),
      ),
    );
  }

  void _loadUserEvents(int pageNumber) {
    switch (_tabController.index) {
      case 0:
        context.read<UserEventsCubit>().getUserUpcomingEvents(pageNumber);
      case 1:
        context.read<UserEventsCubit>().getUserEventInvitations(pageNumber);
      case 2:
        context.read<UserEventsCubit>().getUserPastEvents(pageNumber);
    }
  }

  void _eventItemPressed(Event event) {
    switch (_tabController.index) {
      case 0:
        context.go(PagePaths.userEventTickets(event.id));
      case 1:
        context.go(PagePaths.userEventInvitation(event.id));
      case 2:
      context.go(PagePaths.userEventTickets(event.id));
    }
  }
}

import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/filter_app_bar.dart';
import 'package:event_planr_app/ui/shared/widgets/organization_item_card_landscape.dart';
import 'package:event_planr_app/ui/shared/widgets/organization_item_card_portrait.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ExploreOrganizationsPage extends StatefulWidget {
  const ExploreOrganizationsPage({super.key});

  @override
  State<ExploreOrganizationsPage> createState() =>
      _ExploreOrganizationsPageState();
}

class _ExploreOrganizationsPageState extends State<ExploreOrganizationsPage> {
  final PagingController<int, Organization> _pagingController =
      PagingController(firstPageKey: 1);
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) {
      return;
    }
    initialized = true;

    _pagingController.addPageRequestListener(
      (pageKey) => context.read<ExploreEventsCubit>().filterOrganizations(
            context
                .read<ExploreEventsCubit>()
                .state
                .organizationFilter
                .copyWith(pageNumber: pageKey),
          ),
    );

    context.watch<ExploreEventsCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.eventFilter.pageNumber,
        error: state.exception,
        itemList: state.organizations,
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
    final breakpoints = context.breakpoints;

    final goRouterState = context.goRouterState;
    if (goRouterState.uri.toString() != PagePaths.exploreEvents) {
      return Container();
    }

    return EventScaffold(
      title: l10n.exploreEvents,
      allowAnonymous: true,
      appBar: const FilterAppBar(height: 65),
      body: PagedGridView<int, Organization>(
        pagingController: _pagingController,
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
        builderDelegate: PagedChildBuilderDelegate<Organization>(
          itemBuilder: (context, item, index) {
            return breakpoints.isMobile
                ? FittedBox(
                    child: OrganizationItemCardLandscape(
                      onPressed: () => context.go(
                        PagePaths.organizationDetails(item.id),
                      ),
                      organization: item,
                    ),
                  )
                : FittedBox(
                    child: OrganizationItemCardPortrait(
                      onPressed: () => context.go(
                        PagePaths.organizationDetails(item.id),
                      ),
                      organization: item,
                    ),
                  );
          },
        ),
      ),
    );
  }
}

import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/event/event.dart';
import 'package:event_planr_app/domain/models/organization/organization_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/organization_details/cubit/organization_details_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_landscape.dart';
import 'package:event_planr_app/ui/shared/widgets/event_item_card_portrait.dart';
import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationDetailsPage extends StatefulWidget {
  const OrganizationDetailsPage({super.key});

  @override
  State<OrganizationDetailsPage> createState() =>
      _OrganizationDetailsPageState();
}

class _OrganizationDetailsPageState extends State<OrganizationDetailsPage> {
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

    final organizationId =
        context.goRouterState.pathParameters['organizationId']!;
    _pagingController.addPageRequestListener(
      (pageKey) =>
          context.read<OrganizationDetailsCubit>().getOrganizationEvents(
                organizationId: organizationId,
                pageNumber: pageKey,
              ),
    );

    context.watch<OrganizationDetailsCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.errorCode,
        itemList: state.events,
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

    return EventScaffold(
      title: l10n.organizationDetails,
      allowAnonymous: true,
      body: BlocConsumer<OrganizationDetailsCubit, OrganizationDetailsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == OrganizationDetailsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.organizationDetails != null) {
            return _mainContent(context, state.organizationDetails!);
          }

          return Container();
        },
      ),
    );
  }

  Widget _mainContent(
    BuildContext context,
    OrganizationDetails organizationDetails,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;
    final breakpoints = context.breakpoints;

    return SingleChildScrollView(
      child: MaxWidthBox(
        maxWidth: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 600,
                child: ImageWrapper(
                  imageUrl: organizationDetails.profileImageUrl,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      organizationDetails.name,
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.organizationDetails_Description,
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    organizationDetails.description ?? '-',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.events,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  PagedGridView<int, Event>(
                    pagingController: _pagingController,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: breakpoints.isMobile ? 500 : 400,
                      crossAxisSpacing: 16,
                      mainAxisExtent: breakpoints.isMobile ? 120 : null,
                    ),
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate<Event>(
                      itemBuilder: (context, item, index) {
                        return breakpoints.isMobile
                            ? FittedBox(
                                child: EventItemCardLandscape(
                                  onPressed: () => context.go(
                                    PagePaths.eventDetails(item.id),
                                  ),
                                  event: item,
                                ),
                              )
                            : FittedBox(
                                child: EventItemCardPortrait(
                                  onPressed: () => context.go(
                                    PagePaths.eventDetails(item.id),
                                  ),
                                  event: item,
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationDetailsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationDetailsStatus.error) {
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
    }
  }
}

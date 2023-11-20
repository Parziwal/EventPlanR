import 'package:event_planr_app/domain/models/news_post/organization_news_post.dart';
import 'package:event_planr_app/domain/models/organization/organization_policy.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/cubit/organization_event_news_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/widgets/create_news_post_dialog.dart';
import 'package:event_planr_app/ui/organize/organization_event_news/widgets/news_post_item.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/max_width_box.dart';

class OrganizationEventNewsPage extends StatefulWidget {
  const OrganizationEventNewsPage({super.key});

  @override
  State<OrganizationEventNewsPage> createState() =>
      _OrganizationEventNewsPageState();
}

class _OrganizationEventNewsPageState extends State<OrganizationEventNewsPage> {
  final PagingController<int, OrganizationNewsPost> _pagingController =
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
          .read<OrganizationEventNewsCubit>()
          .getEventNewsPosts(eventId: eventId, pageNumber: pageKey),
    );

    context.watch<OrganizationEventNewsCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.exception,
        itemList: state.newsPosts,
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
    final theme = context.theme;
    final user = context.watch<OrganizeNavbarCubit>().state.user;

    return OrganizeScaffold(
      title: l10n.organizationEventNews,
      showActions: user != null &&
          user.organizationPolicies
              .contains(OrganizationPolicy.newsPostManage),
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => showCreateNewsPostDialog(context),
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => showCreateNewsPostDialog(context),
          icon: const Icon(Icons.add),
          label: Text(l10n.organizationEventNews_AddPost),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body:
          BlocListener<OrganizationEventNewsCubit, OrganizationEventNewsState>(
        listener: _stateListener,
        child: PagedListView(
          pagingController: _pagingController,
          padding: const EdgeInsets.only(top: 8, left: 32, right: 32),
          builderDelegate: PagedChildBuilderDelegate<OrganizationNewsPost>(
            itemBuilder: (context, item, index) => MaxWidthBox(
              maxWidth: 1000,
              child: NewsPostItem(newsPost: item),
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, OrganizationEventNewsState state) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationEventNewsStatus.newsCreated) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.organizationEventNews_Created,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    } else if (state.status == OrganizationEventNewsStatus.newsDeleted) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.organizationEventNews_NewsDeleted,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }
}

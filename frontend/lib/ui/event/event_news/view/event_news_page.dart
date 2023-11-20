import 'package:event_planr_app/domain/models/news_post/news_post.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/event_news/cubit/event_news_cubit.dart';
import 'package:event_planr_app/ui/event/event_news/widgets/news_post_item.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/max_width_box.dart';

class EventNewsPage extends StatefulWidget {
  const EventNewsPage({super.key});

  @override
  State<EventNewsPage> createState() => _EventNewsPageState();
}

class _EventNewsPageState extends State<EventNewsPage> {
  final PagingController<int, NewsPost> _pagingController =
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
          .read<EventNewsCubit>()
          .getEventNewsPosts(eventId: eventId, pageNumber: pageKey),
    );

    context.watch<EventNewsCubit>().stream.listen((state) {
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

    return EventScaffold(
      title: l10n.eventNews,
      allowAnonymous: true,
      body: PagedListView(
        pagingController: _pagingController,
        padding: const EdgeInsets.only(top: 8, left: 32, right: 32),
        builderDelegate: PagedChildBuilderDelegate<NewsPost>(
          itemBuilder: (context, item, index) => MaxWidthBox(
            maxWidth: 1000,
            child: NewsPostItem(newsPost: item),
          ),
        ),
      ),
    );
  }
}

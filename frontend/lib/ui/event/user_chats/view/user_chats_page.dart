import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/chat/chat.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_chats/cubit/user_chats_cubit.dart';
import 'package:event_planr_app/ui/event/user_chats/widgets/add_direct_chat_dialog.dart';
import 'package:event_planr_app/ui/event/user_chats/widgets/chat_contact_item.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserChatsPage extends StatefulWidget {
  const UserChatsPage({super.key});

  @override
  State<UserChatsPage> createState() => _UserChatsPageState();
}

class _UserChatsPageState extends State<UserChatsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final PagingController<int, Chat> _pagingController =
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
      length: 2,
      vsync: this,
    );

    _pagingController.addPageRequestListener(_loadUserChats);

    context.watch<UserChatsCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.errorCode,
        itemList: state.chats,
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

    final goRouterState = context.goRouterState;
    if (goRouterState.uri.toString() != PagePaths.userChats) {
      return Container();
    }

    return EventScaffold(
      title: l10n.userChats,
      mobileFloatingButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: () => showAddDirectChatDialog(context),
              child: const Icon(Icons.add),
            )
          : null,
      desktopActions: [
        if (_tabController.index == 0)
          FilledButton.tonalIcon(
            onPressed: () => showAddDirectChatDialog(context),
            icon: const Icon(Icons.add),
            label: Text(l10n.userChats_AddChat),
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
          ),
      ],
      tabBar: TabBar(
        controller: _tabController,
        onTap: (int index) {
          setState(() {
            _tabController.animateTo(index);
            _pagingController.notifyPageRequestListeners(1);
          });
        },
        tabs: [
          Tab(text: l10n.userChats_Direct),
          Tab(text: l10n.userChats_Event),
        ],
      ),
      body: BlocListener<UserChatsCubit, UserChatsState>(
        listener: _stateListener,
        child: Center(
          child: MaxWidthBox(
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
              builderDelegate: PagedChildBuilderDelegate<Chat>(
                itemBuilder: (context, item, index) =>
                    ChatContactItem(chat: item),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadUserChats(int pageNumber) {
    switch (_tabController.index) {
      case 0:
        context.read<UserChatsCubit>().getDirectChats(pageNumber);
      case 1:
        context.read<UserChatsCubit>().getDirectChats(pageNumber);
    }
  }

  void _stateListener(
      BuildContext context,
      UserChatsState state,
      ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == UserChatsStatus.error) {
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
    } else if (state.status == UserChatsStatus.chatCreated) {
      context.pop();
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.userChats_ChatCreated,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }
}

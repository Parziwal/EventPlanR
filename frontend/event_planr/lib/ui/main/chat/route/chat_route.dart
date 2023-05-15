import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/main/chat/chat.dart';
import 'package:event_planr/ui/main/chat/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> chatRoute(GlobalKey<NavigatorState>? navigationKey) => [
      GoRoute(
        path: 'chat/:userId',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) =>
                injector<ChatCubit>()..getMessages(state.params['userId']!),
            child: const ChatPage(),
          );
        },
        parentNavigatorKey: navigationKey,
      ),
    ];

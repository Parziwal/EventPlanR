import 'package:event_planr/ui/main/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> chatRoute(GlobalKey<NavigatorState>? navigationKey) => [
  GoRoute(
    path: 'chat',
    builder: (BuildContext context, GoRouterState state) {
      return const ChatPage();
    },
    parentNavigatorKey: navigationKey,
  ),
];

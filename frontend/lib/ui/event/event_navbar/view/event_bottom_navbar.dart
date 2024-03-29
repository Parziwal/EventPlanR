import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventBottomNavbar extends StatelessWidget {
  const EventBottomNavbar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final location = context.goRouterState.uri.toString();
    final showBottomNavbar =
        location == PagePaths.exploreEvents ||
        location == PagePaths.userEvents ||
        location == PagePaths.userChats ||
        location == PagePaths.userProfile;

    return Scaffold(
      body: child,
      bottomNavigationBar: showBottomNavbar
          ? NavigationBar(
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.search),
                  label: l10n.eventNavbar_ExploreEvents,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.event),
                  label: l10n.eventNavbar_UserEvents,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.message),
                  label: l10n.eventNavbar_UserMessages,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person),
                  label: l10n.eventNavbar_UserProfile,
                ),
              ],
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              indicatorColor: theme.colorScheme.inversePrimary,
              elevation: 5,
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) => _onItemTapped(index, context),
            )
          : null,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = context.goRouterState.matchedLocation;

    if (location.startsWith(PagePaths.exploreEvents)) {
      return 0;
    } else if (location.startsWith(PagePaths.userEvents)) {
      return 1;
    } else if (location.startsWith(PagePaths.userChats)) {
      return 2;
    } else if (location.startsWith(PagePaths.userProfile)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(PagePaths.exploreEvents);
      case 1:
        context.go(PagePaths.userEvents);
      case 2:
        context.go(PagePaths.userChats);
      case 3:
        context.go(PagePaths.userProfile);
    }
  }
}

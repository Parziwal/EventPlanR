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

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: l10n.navbarUserDashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: l10n.navbarExploreEvents,
          ),
          NavigationDestination(
            icon: const Icon(Icons.event),
            label: l10n.navbarUserEvents,
          ),
          NavigationDestination(
            icon: const Icon(Icons.message),
            label: l10n.navbarUserMessages,
          ),
          NavigationDestination(
            icon: const Icon(Icons.event),
            label: l10n.navbarUserProfile,
          ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: theme.colorScheme.inversePrimary,
        elevation: 5,
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final location = context.goRouterState.matchedLocation;

    if (location.startsWith(PagePaths.userDashboard)) {
      return 0;
    } else if (location.startsWith(PagePaths.exploreEvents)) {
      return 1;
    } else if (location.startsWith(PagePaths.userEvents)) {
      return 2;
    } else if (location.startsWith(PagePaths.userMessages)) {
      return 3;
    } else if (location.startsWith(PagePaths.userProfile)) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goRouter.go(PagePaths.userDashboard);
      case 1:
        context.goRouter.go(PagePaths.exploreEvents);
      case 2:
        context.goRouter.go(PagePaths.userEvents);
      case 3:
        context.goRouter.go(PagePaths.userMessages);
      case 4:
        context.goRouter.go(PagePaths.userProfile);
    }
  }
}

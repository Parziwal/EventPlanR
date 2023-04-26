import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.event),
            label: 'Event',
          ),
          NavigationDestination(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).location;
    if (location.startsWith('/main/home')) {
      return 0;
    } else if (location.startsWith('/main/explore')) {
      return 1;
    } else if (location.startsWith('/main/event')) {
      return 2;
    } else if (location.startsWith('/main/message')) {
      return 3;
    } else if (location.startsWith('/main/profile')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/main/home');
        break;
      case 1:
        GoRouter.of(context).go('/main/explore');
        break;
      case 2:
        GoRouter.of(context).go('/main/event');
        break;
      case 3:
        GoRouter.of(context).go('/main/message');
        break;
      case 4:
        GoRouter.of(context).go('/main/profile');
        break;
    }
  }
}

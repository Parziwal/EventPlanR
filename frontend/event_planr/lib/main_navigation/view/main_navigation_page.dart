import 'package:event_planr/event/event.dart';
import 'package:event_planr/explore/view/explore_page.dart';
import 'package:event_planr/home/view/home_page.dart';
import 'package:event_planr/main_navigation/cubit/main_navigation_cubit.dart';
import 'package:event_planr/message/message.dart';
import 'package:event_planr/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationPage extends StatelessWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const MainNavigationView(),
    );
  }
}

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          HomePage(),
          ExplorePage(),
          EventPage(),
          MessagePage(),
          ProfilePage()
        ],
      ),
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
        selectedIndex: selectedTab.index,
        onDestinationSelected: (index) =>
            context.read<HomeCubit>().setTab(NavigationTab.values[index]),
      ),
    );
  }
}

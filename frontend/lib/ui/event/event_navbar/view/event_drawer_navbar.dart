import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/ui/shared/widgets/drawer_tile.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventDrawerNavbar extends StatefulWidget {
  const EventDrawerNavbar({required this.child, super.key});

  final Widget child;

  @override
  State<EventDrawerNavbar> createState() => _EventDrawerNavbarState();
}

class _EventDrawerNavbarState extends State<EventDrawerNavbar> {
  bool _desktopDrawerIsOpen = true;

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.breakpoints;

    return BlocListener<EventNavbarCubit, EventNavbarState>(
      listener: _stateListener,
      child: Scaffold(
        appBar: breakpoints.isTablet ? _appBar() : null,
        drawer: breakpoints.isTablet ? _drawer() : null,
        body: SafeArea(
          child: Row(
            children: [
              if (breakpoints.isDesktop) _drawer(),
              Expanded(
                child: Column(
                  children: [
                    if (breakpoints.isDesktop) _appBar(),
                    Expanded(child: widget.child),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    final breakpoints = context.breakpoints;
    final state = context.watch<EventNavbarCubit>().state;
    final title =
        state.desktopTitle.isNotEmpty ? ' - ${state.desktopTitle}' : '';

    return AppBar(
      title: Text('${Env.appName}$title'),
      elevation: 5,
      leading: breakpoints.isDesktop
          ? IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  _desktopDrawerIsOpen = !_desktopDrawerIsOpen;
                });
              },
            )
          : null,
      actions: [
        if (state.user != null)
          InkWell(
            onTap: () => context.go(PagePaths.userProfile),
            child: AvatarIcon(
              altText: state.user!.getUserMonogram(context),
            ),
          ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () => context.read<EventNavbarCubit>().logout(),
          icon: const Icon(Icons.logout),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _drawer() {
    final l10n = context.l10n;
    final location = context.goRouterState.matchedLocation;

    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: Drawer(
        shape: const RoundedRectangleBorder(),
        width: _desktopDrawerIsOpen ? 300 : 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 150,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: Image.asset(
                  'assets/logo/logo.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                itemExtent: 50,
                padding: EdgeInsets.zero,
                children: [
                  DrawerTile(
                    icon: const Icon(Icons.home),
                    label: Text(l10n.navbar_UserDashboard),
                    onTap: () => context.go(PagePaths.userDashboard),
                    selected: location == PagePaths.userDashboard,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.search),
                    label: Text(l10n.navbar_ExploreEvents),
                    onTap: () => context.go(PagePaths.exploreEvents),
                    selected: location == PagePaths.exploreEvents,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.event),
                    label: Text(l10n.navbar_UserEvents),
                    onTap: () => context.go(PagePaths.userEvents),
                    selected: location == PagePaths.userEvents,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.message),
                    label: Text(l10n.navbar_UserMessages),
                    onTap: () => context.go(PagePaths.userMessages),
                    selected: location == PagePaths.userMessages,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.event_note_outlined),
                    label: Text(l10n.navbar_ManageEvents),
                    onTap: () => context.go(PagePaths.userOrganizations),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, EventNavbarState state) {
    if (state.status == EventNavbarStatus.loggedOut) {
      context.go(PagePaths.signIn);
    }
  }
}

import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/env/env.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/ui/shared/widgets/drawer_tile.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventDrawerNavbar extends StatefulWidget {
  const EventDrawerNavbar({
    required this.child,
    required this.desktopTitle,
    super.key,
  });

  final Widget child;
  final String desktopTitle;

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
    final l10n = context.l10n;
    final state = context.watch<EventNavbarCubit>().state;
    final title =
        widget.desktopTitle.isNotEmpty ? ' - ${widget.desktopTitle}' : '';

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
        if (state.user != null) ...[
          InkWell(
            onTap: () => context.go(PagePaths.userProfileEdit),
            child: AvatarIcon(
              imageUrl: state.user!.picture,
              altText: state.user!.getUserMonogram(context),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => context.read<EventNavbarCubit>().logout(),
            icon: const Icon(Icons.logout),
          ),
        ] else ...[
          FilledButton(
            onPressed: () => context.go(PagePaths.signIn),
            child: Text(l10n.eventNavbar_SignIn),
          ),
        ],
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _drawer() {
    final l10n = context.l10n;
    final theme = context.theme;
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
                    icon: const Icon(Icons.search),
                    label: Text(l10n.eventNavbar_ExploreEvents),
                    onTap: () => context.go(PagePaths.exploreEvents),
                    selected: location == PagePaths.exploreEvents,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.event),
                    label: Text(l10n.eventNavbar_UserEvents),
                    onTap: () => context.go(PagePaths.userEvents),
                    selected: location == PagePaths.userEvents,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.message),
                    label: Text(l10n.eventNavbar_UserMessages),
                    onTap: () => context.go(PagePaths.userChats),
                    selected: location == PagePaths.userChats,
                  ),
                  if (context.read<EventNavbarCubit>().state.user != null) ...[
                    DrawerTile(
                      icon: const Icon(Icons.person_outline),
                      label: Text(l10n.userProfile_EditProfile),
                      onTap: () => context.go(PagePaths.userProfileEdit),
                      selected: location == PagePaths.userProfileEdit,
                    ),
                    DrawerTile(
                      icon: const Icon(Icons.security_outlined),
                      label: Text(l10n.userProfile_Security),
                      onTap: () => context.go(PagePaths.userProfileSecurity),
                      selected: location == PagePaths.userProfileSecurity,
                    ),
                    DrawerTile(
                      icon: const Icon(Icons.settings),
                      label: Text(l10n.userProfile_Settings),
                      onTap: () => context.go(PagePaths.userProfileSettings),
                      selected: location == PagePaths.userProfileSettings,
                    ),
                    DrawerTile(
                      icon: const Icon(Icons.event_note_outlined),
                      label: Text(l10n.eventNavbar_ManageEvents),
                      onTap: () => context.go(PagePaths.userOrganizations),
                    ),
                  ],
                  if (kIsWeb)
                    InkWell(
                      onTap: UrlLauncherUtils.downloadAndroidApk,
                      child: Center(
                        child: Text(
                          'Download mobile app',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ),
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

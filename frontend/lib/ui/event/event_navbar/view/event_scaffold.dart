import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_navbar.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EventScaffold extends StatelessWidget {
  const EventScaffold({
    super.key,
    this.title,
    this.appBar,
    this.body,
    this.tabBar,
    this.mobileActions,
    this.mobileFloatingButton,
    this.mobileBottomSheet,
    this.desktopActions,
    this.allowAnonymous = false,
  });

  final String? title;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final TabBar? tabBar;
  final List<Widget>? mobileActions;
  final FloatingActionButton? mobileFloatingButton;
  final Widget? mobileBottomSheet;
  final List<Widget>? desktopActions;
  final bool allowAnonymous;

  @override
  Widget build(BuildContext context) {
    final user = context.read<EventNavbarCubit>().state.user;

    return EventNavbar(
      desktopTitle: title ?? '',
      child: allowAnonymous || user != null
          ? _mainContent(context)
          : _notSignedInContent(context),
    );
  }

  Widget _mainContent(BuildContext context) {
    final breakpoints = context.breakpoints;

    return Scaffold(
      appBar: _appBar(context),
      bottomSheet: breakpoints.isMobile ? mobileBottomSheet : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (breakpoints.isDesktop) _desktopTabBar(context),
          if (breakpoints.largerThan(MOBILE)) _desktopActions(),
          if (body != null) Expanded(child: body!),
        ],
      ),
      floatingActionButton: breakpoints.isMobile ? mobileFloatingButton : null,
    );
  }

  Widget _notSignedInContent(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.eventNavbar_SignInForMore,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => context.go(PagePaths.signIn),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                textStyle: theme.textTheme.titleMedium,
              ),
              child: Text(l10n.eventNavbar_SignIn),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget? _appBar(BuildContext context) {
    final breakpoints = context.breakpoints;

    if (appBar != null) {
      return appBar;
    } else if (breakpoints.isMobile) {
      return AppBar(
        title: title != null ? Text(title!) : null,
        actions: mobileActions,
        bottom: tabBar,
        elevation: 5,
      );
    } else {
      return AppBar(
        toolbarHeight: 0,
        elevation: 3,
        bottom: breakpoints.largerThan(TABLET) ? null : tabBar,
      );
    }
  }

  Widget _desktopTabBar(BuildContext context) {
    return MaxWidthBox(
      maxWidth: 600,
      child: Card(
        margin: const EdgeInsets.only(top: 16),
        clipBehavior: Clip.hardEdge,
        child: tabBar ?? Container(),
      ),
    );
  }

  Widget _desktopActions() {
    if (desktopActions == null || desktopActions!.isEmpty) {
      return Container();
    }

    return MaxWidthBox(
      maxWidth: 1000,
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          primary: true,
          child: Row(
            children: [
              ...?desktopActions,
            ],
          ),
        ),
      ),
    );
  }
}

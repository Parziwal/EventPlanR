import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_navbar.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_drawer.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class OrganizeScaffold extends StatelessWidget {
  const OrganizeScaffold({
    super.key,
    this.title,
    this.appBar,
    this.body,
    this.tabBar,
    this.mobileActions,
    this.mobileFloatingButton,
    this.desktopActions,
    this.showActions = true,
  });

  final String? title;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final TabBar? tabBar;
  final List<Widget>? mobileActions;
  final FloatingActionButton? mobileFloatingButton;
  final List<Widget>? desktopActions;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.breakpoints;

    return OrganizeNavbar(
      desktopTitle: title ?? '',
      child: Scaffold(
        appBar: _appBar(context),
        drawer: breakpoints.isMobile ? const OrganizeDrawer() : null,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (breakpoints.isDesktop) _desktopTabBar(context),
            if (breakpoints.largerThan(MOBILE) && showActions)
              _desktopActions(),
            if (body != null) Expanded(child: body!),
          ],
        ),
        floatingActionButton:
            breakpoints.isMobile && showActions ? mobileFloatingButton : null,
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
        actions: showActions ? mobileActions : null,
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
    if (tabBar == null) {
      return Container();
    }

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
    if (desktopActions == null) {
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

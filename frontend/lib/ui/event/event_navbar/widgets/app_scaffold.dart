import 'package:event_planr_app/app/app.dart';
import 'package:event_planr_app/ui/event/event_navbar/cubit/event_navbar_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title,
    this.appBar,
    this.body,
    this.mobileActions,
    this.tabBar,
  });

  final String? title;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final List<Widget>? mobileActions;
  final TabBar? tabBar;

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.breakpoints;
    context.read<EventNavbarCubit>().changeDesktopTitle(title);

    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          if (breakpoints.isDesktop) _desktopTabBar(context),
          if (body != null) Expanded(child: body!),
        ],
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
    final theme = context.theme;
    return MaxWidthBox(
      maxWidth: 600,
      child: Card(
        margin: const EdgeInsets.only(top: 16),
        clipBehavior: Clip.hardEdge,
        child: tabBar ?? Container(),
      ),
    );
  }
}

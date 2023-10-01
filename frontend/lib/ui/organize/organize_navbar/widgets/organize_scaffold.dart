import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_drawer.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class OrganizeScaffold extends StatelessWidget {
  const OrganizeScaffold({
    super.key,
    this.title,
    this.appBar,
    this.body,
    this.mobileActions,
    this.mobileFloatingButton,
    this.desktopActions,
  });

  final String? title;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final List<Widget>? mobileActions;
  final FloatingActionButton? mobileFloatingButton;
  final List<Widget>? desktopActions;

  @override
  Widget build(BuildContext context) {
    context.read<OrganizeNavbarCubit>().changeTitle(title);
    final breakpoints = context.breakpoints;

    return Scaffold(
      appBar: _appBar(context),
      drawer: breakpoints.isMobile ? const OrganizeDrawer() : null,
      body: Column(
        children: [
          if (breakpoints.largerThan(MOBILE)) _desktopActions(),
          if (body != null) Expanded(child: body!),
        ],
      ),
      floatingActionButton: breakpoints.isMobile ? mobileFloatingButton : null,
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
        elevation: 5,
      );
    }

    return null;
  }

  Widget _desktopActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          ...?desktopActions,
        ],
      ),
    );
  }
}

import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_drawer.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrganizeNavbar extends StatefulWidget {
  const OrganizeNavbar({required this.child, super.key});

  final Widget child;

  @override
  State<OrganizeNavbar> createState() => _OrganizeNavbarState();
}

class _OrganizeNavbarState extends State<OrganizeNavbar> {
  bool _desktopDrawerIsOpen = true;

  @override
  Widget build(BuildContext context) {
    final breakpoints = context.breakpoints;

    return BlocListener<OrganizeNavbarCubit, OrganizeNavbarState>(
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

    final state = context.watch<OrganizeNavbarCubit>().state;
    final title =
        state.desktopTitle.isNotEmpty ? ' - ${state.desktopTitle}' : '';

    return AppBar(
      title: Text('${l10n.organizeNavbar_EventManager}$title'),
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
          AvatarIcon(altText: state.user!.getUserMonogram(context)),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () => context.read<OrganizeNavbarCubit>().logout(),
          icon: const Icon(Icons.logout),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _drawer() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: SizedBox(
        width: _desktopDrawerIsOpen ? 300 : 0,
        child: const OrganizeDrawer(),
      ),
    );
  }

  void _stateListener(BuildContext context, OrganizeNavbarState state) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizeNavbarStatus.loggedOut) {
      context.go(PagePaths.signIn);
    } else if (state.status == OrganizeNavbarStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.errorCode!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    }
  }
}

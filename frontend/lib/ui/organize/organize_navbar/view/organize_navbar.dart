import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_drawer.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      listener: (context, state) {},
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

    return AppBar(
      title: BlocBuilder<OrganizeNavbarCubit, OrganizeNavbarState>(
        builder: (_, state) {
          final title =
              state.desktopTitle.isNotEmpty ? ' - ${state.desktopTitle}' : '';
          return Text('${l10n.organizeNavbarEventManager}$title');
        },
      ),
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
        const CircleAvatar(
          foregroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80'),
        ),
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
}

import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/shared/widgets/drawer_tile.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrganizeDrawer extends StatelessWidget {
  const OrganizeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final location = context.goRouterState.matchedLocation;

    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1780&q=80'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                      child: Text(
                    'Organization name',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              itemExtent: 50,
              padding: EdgeInsets.zero,
              children: [
                DrawerTile(
                  icon: const Icon(Icons.event),
                  label: Text(l10n.organizeNavbarEvents),
                  onTap: () => context.go(
                    PagePaths.userOrganizationEvents('Test'),
                  ),
                  selected:
                      location == PagePaths.userOrganizationEvents('Test'),
                ),
                DrawerTile(
                  icon: const Icon(Icons.group),
                  label: Text(l10n.organizeNavbarSwitchOrganization),
                  onTap: () => context.go(PagePaths.userOrganizations),
                  selected: location == PagePaths.userOrganizations,
                ),
                const Divider(),
                DrawerTile(
                  icon: const Icon(Icons.arrow_back_ios),
                  label: Text(l10n.organizeNavbarBackToMain),
                  onTap: () => context.go(PagePaths.userDashboard),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

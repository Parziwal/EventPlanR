import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_drawer_header.dart';
import 'package:event_planr_app/ui/shared/widgets/drawer_tile.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrganizeDrawer extends StatelessWidget {
  const OrganizeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final location = context.goRouterState.matchedLocation;
    final event = context.watch<OrganizeNavbarCubit>().state.event;

    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 100,
            child: OrganizeDrawerHeader(),
          ),
          Expanded(
            child: ListView(
              itemExtent: 50,
              padding: EdgeInsets.zero,
              children: [
                if (event != null) ...[
                  DrawerTile(
                    icon: const Icon(Icons.event_available),
                    label: Text(event.name),
                    onTap: () => context
                        .go(PagePaths.organizationEventDetails(event.id)),
                    selected: location ==
                        PagePaths.organizationEventDetails(event.id),
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.stacked_line_chart),
                    label: Text(l10n.organizeNavbar_Statistics),
                    onTap: () {},
                    selected: false,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.credit_card),
                    label: Text(l10n.organizeNavbar_Ticket),
                    onTap: () => context
                        .go(PagePaths.organizationEventTickets(event.id)),
                    selected: location ==
                        PagePaths.organizationEventTickets(event.id),
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.shopping_cart),
                    label: Text(l10n.organizeNavbar_Order),
                    onTap: () {},
                    selected: false,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.post_add),
                    label: Text(l10n.organizeNavbar_NewsPost),
                    onTap: () =>
                        context.go(PagePaths.organizationEventNews(event.id)),
                    selected:
                        location == PagePaths.organizationEventNews(event.id),
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.insert_invitation),
                    label: Text(l10n.organizeNavbar_Invite),
                    onTap: () {},
                    selected: false,
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.chat),
                    label: Text(l10n.organizeNavbar_Chat),
                    onTap: () => context
                        .go(PagePaths.organizationEventChat(event.chatId)),
                    selected: location ==
                        PagePaths.organizationEventChat(event.chatId),
                  ),
                  DrawerTile(
                    icon: const Icon(Icons.fact_check),
                    label: Text(l10n.organizeNavbar_CheckIn),
                    onTap: () {},
                    selected: false,
                  ),
                  const Divider(),
                ],
                DrawerTile(
                  icon: const Icon(Icons.event),
                  label: Text(l10n.organizeNavbar_Events),
                  onTap: () => context.go(
                    PagePaths.organizationEvents,
                  ),
                  selected: location == PagePaths.organizationEvents,
                ),
                DrawerTile(
                  icon: const Icon(Icons.group),
                  label: Text(l10n.organizeNavbar_SwitchOrganization),
                  onTap: () => context.go(PagePaths.userOrganizations),
                  selected: location == PagePaths.userOrganizations,
                ),
                const Divider(),
                DrawerTile(
                  icon: const Icon(Icons.arrow_back_ios),
                  label: Text(l10n.organizeNavbar_BackToMain),
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

import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/ui/organize/user_organizations/widgets/organization_item.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserOrganizationsPage extends StatelessWidget {
  const UserOrganizationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return OrganizeScaffold(
      title: l10n.userOrganizations,
      body: Center(
        child: MaxWidthBox(
          maxWidth: 1000,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 700,
              mainAxisExtent: 100,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 1,
            padding: const EdgeInsets.only(top: 8, left: 32, right: 32),
            itemBuilder: (context, index) {
              return const OrganizationItem();
            },
          ),
        ),
      ),
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => context.go(PagePaths.userOrganizationsCreate),
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => context.go(PagePaths.userOrganizationsCreate),
          icon: const Icon(Icons.add),
          label: Text(l10n.userOrganizationsCreateOrganization),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}

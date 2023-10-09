import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/widgets/organization_member_item.dart';
import 'package:event_planr_app/ui/shared/widgets/image_wrapper.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserOrganizationDetailsPage extends StatelessWidget {
  const UserOrganizationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return OrganizeScaffold(
      title: l10n.userOrganizationDetails,
      mobileActions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
      ],
      mobileFloatingButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: Text(l10n.userOrganizationDetailsEditOrganization),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(width: 16),
        FilledButton.tonalIcon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: Text(l10n.userOrganizationDetailsAddMember),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: MaxWidthBox(
          maxWidth: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ImageWrapper(),
              const SizedBox(height: 16),
              Text(
                'Organization name',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.userOrganizationDetailsDescription,
                style: theme.textTheme.titleLarge,
              ),
              Text(
                'Description......',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),
              const OrganizationMember(),
            ],
          ),
        ),
      ),
    );
  }
}

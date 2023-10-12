import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/ui/organize/user_organizations/cubit/user_organizations_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationItem extends StatelessWidget {
  OrganizationItem({required this.organization})
      : super(key: ValueKey(organization.id));

  final Organization organization;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () => context
          .read<UserOrganizationsCubit>()
          .setOrganization(organization.id),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AvatarIcon(
                imageUrl: organization.profileImageUrl,
                altText: organization.name[0],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  organization.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

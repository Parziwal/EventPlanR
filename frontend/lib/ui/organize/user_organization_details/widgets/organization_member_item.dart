import 'package:event_planr_app/domain/models/user/organization_member.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/cubit/user_organization_details_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/widgets/add_or_edit_member_dialog.dart';
import 'package:event_planr_app/ui/shared/widgets/avatar_icon.dart';
import 'package:event_planr_app/ui/shared/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrganizationMemberItem extends StatelessWidget {
  const OrganizationMemberItem({required this.member, super.key});

  final OrganizationMember member;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  AvatarIcon(altText: member.getUserMonogram(context)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(member.getUserFullName(context)),
                        Text(member.email),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () =>
                        showAddOrEditMemberDialog(context, member: member),
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () => _removeMember(context),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
            Text(
              'Permissions: ${member.organizationPolicies.map(
                    l10n.translateEnums,
                  ).join(', ')}',
            ),
          ],
        ),
      ),
    );
  }

  void _removeMember(BuildContext context) {
    final l10n = context.l10n;

    showConfirmationDialog(
      context,
      message: l10n.userOrganizationDetails_AreYouSureYouWantToRemoveUser(
        member.getUserFullName(context),
      ),
    ).then((value) {
      if (value ?? false) {
        context
            .read<UserOrganizationDetailsCubit>()
            .removeMemberFromOrganization(member.id);
      }
    });
  }
}

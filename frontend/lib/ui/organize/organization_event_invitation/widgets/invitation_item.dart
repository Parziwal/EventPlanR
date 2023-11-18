import 'package:event_planr_app/domain/models/invitation/event_invitation.dart';
import 'package:event_planr_app/domain/models/invitation/invitation_status_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/organize/organization_event_invitation/cubit/organization_event_invitation_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InvitationItem extends StatelessWidget {
  const InvitationItem({required this.invitation, super.key});

  final EventInvitation invitation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Container(
            color: switch (invitation.status) {
              InvitationStatusEnum.pending => theme.colorScheme.secondary,
              InvitationStatusEnum.accept => theme.colorScheme.tertiary,
              InvitationStatusEnum.deny => theme.colorScheme.error,
            },
            width: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invitation.getUserFullName(context),
                    style: theme.textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${l10n.organizationEventInvitation_Status}: '
                    '${l10n.translateEnums(invitation.status.name)}',
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${l10n.organizationEventInvitation_Created}: '
                    '${DateFormat.yMd().format(invitation.created)}',
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${l10n.organizationEventInvitation_CreatedBy}: '
                    '${invitation.createdBy}',
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => context
                .read<OrganizationEventInvitationCubit>()
                .deleteInvitation(invitation.id),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

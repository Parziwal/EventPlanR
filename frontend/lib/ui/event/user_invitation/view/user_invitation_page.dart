import 'package:event_planr_app/domain/models/invitation/invitation_status_enum.dart';
import 'package:event_planr_app/domain/models/invitation/user_invitation.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/event/user_invitation/cubit/user_invitation_cubit.dart';
import 'package:event_planr_app/ui/shared/widgets/confirmation_dialog.dart';
import 'package:event_planr_app/ui/shared/widgets/label.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserInvitationPage extends StatelessWidget {
  const UserInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final invitationStatus =
        context.watch<UserInvitationCubit>().state.invitation?.status ??
            InvitationStatusEnum.pending;

    return EventScaffold(
      title: l10n.userInvitation,
      mobileActions: [
        if (invitationStatus != InvitationStatusEnum.pending)
          IconButton(
            onPressed: () => _changeInvitationStatus(context),
            icon: invitationStatus == InvitationStatusEnum.deny
                ? const Icon(Icons.done)
                : const Icon(Icons.block),
          ),
      ],
      desktopActions: [
        if (invitationStatus != InvitationStatusEnum.pending)
          FilledButton.tonalIcon(
            onPressed: () => _changeInvitationStatus(context),
            icon: invitationStatus == InvitationStatusEnum.deny
                ? const Icon(Icons.done)
                : const Icon(Icons.block),
            label: Text(
              invitationStatus == InvitationStatusEnum.deny
                  ? l10n.userInvitation_Accept
                  : l10n.userInvitation_Deny,
            ),
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
              padding: const EdgeInsets.all(16),
            ),
          ),
      ],
      body: BlocConsumer<UserInvitationCubit, UserInvitationState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == UserInvitationStatus.loading) {
            return const LoadingIndicator();
          } else if (state.invitation != null) {
            return _mainContent(context, state.invitation!);
          }

          return Container();
        },
      ),
    );
  }

  void _stateListener(BuildContext context, UserInvitationState state) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == UserInvitationStatus.invitationAccepted ||
        state.status == UserInvitationStatus.invitationDenied) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.status == UserInvitationStatus.invitationAccepted
                  ? l10n.userInvitation_InvitationAccepted
                  : l10n.userInvitation_InvitationDenied,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }

  Widget _mainContent(BuildContext context, UserInvitation invitation) {
    final l10n = context.l10n;
    final theme = context.theme;

    return MaxWidthBox(
      maxWidth: 1000,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Label(
              label: l10n.userInvitation_EventName,
              value: invitation.eventName,
              textStyle: theme.textTheme.titleLarge,
            ),
            Label(
              label: l10n.userInvitation_OrganizationName,
              value: invitation.organizationName,
              textStyle: theme.textTheme.titleMedium,
            ),
            Label(
              label: l10n.userInvitation_Status,
              value: l10n.translateEnums(
                invitation.status.name,
              ),
              textStyle: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 300,
              child: Stack(
                children: [
                  PrettyQrView.data(
                    data: invitation.id,
                    decoration: PrettyQrDecoration(
                      shape: PrettyQrRoundedSymbol(
                        color: invitation.status == InvitationStatusEnum.pending
                            ? theme.colorScheme.inversePrimary
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  if (invitation.status == InvitationStatusEnum.pending)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          color: theme.colorScheme.surface,
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton(
                                onPressed: () => context
                                    .read<UserInvitationCubit>()
                                    .changeInvitationStatus(
                                      invitationId: invitation.id,
                                      accept: true,
                                    ),
                                style: FilledButton.styleFrom(
                                  textStyle: theme.textTheme.titleMedium,
                                ),
                                child: Text(l10n.userInvitation_Accept),
                              ),
                              const SizedBox(width: 8),
                              FilledButton.tonal(
                                onPressed: () => context
                                    .read<UserInvitationCubit>()
                                    .changeInvitationStatus(
                                      invitationId: invitation.id,
                                      accept: false,
                                    ),
                                style: FilledButton.styleFrom(
                                  textStyle: theme.textTheme.titleMedium,
                                ),
                                child: Text(l10n.userInvitation_Deny),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (invitation.status == InvitationStatusEnum.deny)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Placeholder(
                        color: theme.colorScheme.primaryContainer,
                        strokeWidth: 5,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeInvitationStatus(BuildContext context) {
    final invitation = context.read<UserInvitationCubit>().state.invitation;
    if (invitation == null) {
      return;
    }

    final l10n = context.l10n;

    showConfirmationDialog(
      context,
      message: l10n.userInvitation_AreYouSureYouWantToInvitation(
        invitation.status == InvitationStatusEnum.deny
            ? l10n.userInvitation_Accept
            : l10n.userInvitation_Deny,
      ),
    ).then((value) {
      if (value ?? false) {
        context.read<UserInvitationCubit>().changeInvitationStatus(
              invitationId: invitation.id,
              accept: invitation.status == InvitationStatusEnum.deny,
            );
      }
    });
  }
}

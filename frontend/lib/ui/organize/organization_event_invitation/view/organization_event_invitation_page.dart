import 'package:event_planr_app/domain/models/invitation/event_invitation.dart';
import 'package:event_planr_app/domain/models/organization/organization_policy.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/organization_event_invitation/cubit/organization_event_invitation_cubit.dart';
import 'package:event_planr_app/ui/organize/organization_event_invitation/widgets/create_invitation_dialog.dart';
import 'package:event_planr_app/ui/organize/organization_event_invitation/widgets/invitation_item.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:responsive_framework/responsive_framework.dart';

class OrganizationEventInvitationPage extends StatefulWidget {
  const OrganizationEventInvitationPage({super.key});

  @override
  State<OrganizationEventInvitationPage> createState() =>
      _OrganizationEventInvitationPageState();
}

class _OrganizationEventInvitationPageState
    extends State<OrganizationEventInvitationPage> {
  final PagingController<int, EventInvitation> _pagingController =
      PagingController(firstPageKey: 1);
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (initialized) {
      return;
    }
    initialized = true;

    final eventId = context.goRouterState.pathParameters['eventId']!;
    _pagingController.addPageRequestListener(
      (pageKey) => context
          .read<OrganizationEventInvitationCubit>()
          .getEventInvitations(eventId: eventId, pageNumber: pageKey),
    );

    context.watch<OrganizationEventInvitationCubit>().stream.listen((state) {
      _pagingController.value = PagingState(
        nextPageKey: state.pageNumber,
        error: state.errorCode,
        itemList: state.invitations,
      );
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final user = context.watch<OrganizeNavbarCubit>().state.user;

    return OrganizeScaffold(
      title: l10n.organizationEventInvitation,
      showActions: user != null &&
          user.organizationPolicies
              .contains(OrganizationPolicy.invitationManage),
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => showCreateInvitationDialog(context),
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => showCreateInvitationDialog(context),
          icon: const Icon(Icons.add),
          label: Text(l10n.organizationEventInvitation_CreateInvitation),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body: BlocListener<OrganizationEventInvitationCubit,
          OrganizationEventInvitationState>(
        listener: _stateListener,
        child: MaxWidthBox(
          maxWidth: 1000,
          child: PagedGridView(
            pagingController: _pagingController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              mainAxisExtent: 150,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
            builderDelegate: PagedChildBuilderDelegate<EventInvitation>(
              itemBuilder: (context, item, index) =>
                  InvitationItem(invitation: item),
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    OrganizationEventInvitationState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == OrganizationEventInvitationStatus.invitationCreated) {
      context.pop();
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.organizationEventInvitation_InvitationCreated,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    } else if (state.status ==
        OrganizationEventInvitationStatus.invitationDeleted) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.organizationEventInvitation_InvitationDeleted,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }
}

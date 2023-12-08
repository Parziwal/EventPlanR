import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/organization/organization_policy.dart';
import 'package:event_planr_app/domain/models/organization/user_organization_details.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/cubit/user_organization_details_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/widgets/add_or_edit_member_dialog.dart';
import 'package:event_planr_app/ui/organize/user_organization_details/widgets/organization_member_item.dart';
import 'package:event_planr_app/ui/shared/widgets/confirmation_dialog.dart';
import 'package:event_planr_app/ui/shared/widgets/image_picker_item.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class UserOrganizationDetailsPage extends StatelessWidget {
  const UserOrganizationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final user = context.watch<OrganizeNavbarCubit>().state.user;

    return OrganizeScaffold(
      title: l10n.userOrganizationDetails,
      showActions: user != null &&
          user.organizationPolicies
              .contains(OrganizationPolicy.organizationEventManage),
      mobileActions: [
        IconButton(
          onPressed: () => context.go(PagePaths.userOrganizationEdit),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () => _deleteOrganization(context),
          icon: const Icon(Icons.delete),
        ),
      ],
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => showAddOrEditMemberDialog(context),
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => showAddOrEditMemberDialog(context),
          icon: const Icon(Icons.add),
          label: Text(l10n.userOrganizationDetails_AddMember),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(width: 16),
        FilledButton.tonalIcon(
          onPressed: () => context.go(PagePaths.userOrganizationEdit),
          icon: const Icon(Icons.edit),
          label: Text(l10n.userOrganizationDetails_EditOrganization),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(width: 16),
        FilledButton.tonalIcon(
          onPressed: () => _deleteOrganization(context),
          icon: const Icon(Icons.delete),
          label: Text(l10n.userOrganizationDetails_DeleteOrganization),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
      body: BlocConsumer<UserOrganizationDetailsCubit,
          UserOrganizationDetailsState>(
        listener: _stateListener,
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == UserOrganizationDetailsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.organizationDetails != null) {
            return _mainContent(context, state.organizationDetails!);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _mainContent(
    BuildContext context,
    UserOrganizationDetails organizationDetails,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: MaxWidthBox(
        maxWidth: 800,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImagePickerItem(
              imagePicked: (file) => context
                  .read<UserOrganizationDetailsCubit>()
                  .uploadOrganizationProfileImage(file),
              imageUrl: organizationDetails.profileImageUrl,
            ),
            const SizedBox(height: 16),
            Text(
              organizationDetails.name,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.userOrganizationDetails_Description,
              style: theme.textTheme.titleLarge,
            ),
            Text(
              organizationDetails.description,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 32),
            ...organizationDetails.members.map(
              (o) => OrganizationMemberItem(
                member: o,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _stateListener(
    BuildContext context,
    UserOrganizationDetailsState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == UserOrganizationDetailsStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.exception!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    } else if (state.status ==
        UserOrganizationDetailsStatus.organizationDeleted) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.userOrganizationDetails_OrganizationDeleted,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      context.go(PagePaths.userOrganizations);
    }
  }

  void _deleteOrganization(BuildContext context) {
    final l10n = context.l10n;
    final organizationDetails =
        context.read<UserOrganizationDetailsCubit>().state.organizationDetails;

    if (organizationDetails != null) {
      showConfirmationDialog(
        context,
        message:
            l10n.userOrganizationDetails_AreYouSureYouWantToDeleteOrganization(
          organizationDetails.name,
        ),
      ).then((value) {
        if (value ?? false) {
          context.read<UserOrganizationDetailsCubit>().deleteOrganization();
        }
      });
    }
  }
}

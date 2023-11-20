import 'package:event_planr_app/app/router.dart';
import 'package:event_planr_app/domain/models/organization/organization.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/cubit/organize_navbar_cubit.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/ui/organize/user_organizations/cubit/user_organizations_cubit.dart';
import 'package:event_planr_app/ui/organize/user_organizations/widgets/organization_item.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocConsumer<UserOrganizationsCubit, UserOrganizationsState>(
        listener: _stateListener,
        builder: (context, state) {
          if (state.status == UserOrganizationsStatus.loading) {
            return const LoadingIndicator();
          } else if (state.organizations != null) {
            return _mainContent(state.organizations!);
          } else {
            return Container();
          }
        },
      ),
      mobileFloatingButton: FloatingActionButton(
        onPressed: () => context.go(PagePaths.userOrganizationCreate),
        child: const Icon(Icons.add),
      ),
      desktopActions: [
        FilledButton.tonalIcon(
          onPressed: () => context.go(PagePaths.userOrganizationCreate),
          icon: const Icon(Icons.add),
          label: Text(l10n.userOrganizations_CreateOrganization),
          style: FilledButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  void _stateListener(BuildContext context, UserOrganizationsState state) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == UserOrganizationsStatus.error) {
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
    } else if (state.status == UserOrganizationsStatus.organizationChanged) {
      context.read<OrganizeNavbarCubit>().refreshCurrentOrganization();
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.userOrganizations_OrganizationSelected,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
    }
  }

  Widget _mainContent(List<Organization> organizations) {
    return Center(
      child: MaxWidthBox(
        maxWidth: 1000,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 700,
            mainAxisExtent: 100,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: organizations.length,
          padding: const EdgeInsets.only(top: 8, left: 32, right: 32),
          itemBuilder: (context, i) {
            return OrganizationItem(organization: organizations[i]);
          },
        ),
      ),
    );
  }
}

import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_organization/cubit/create_or_edit_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_organization/widgets/create_or_edit_organization_form.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class CreateOrEditOrganizationPage extends StatelessWidget {
  const CreateOrEditOrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;


    return BlocConsumer<CreateOrEditOrganizationCubit,
        CreateOrEditOrganizationState>(
      listener: _stateListener,
      builder: (context, state) {
        return OrganizeScaffold(
          title: state.edit
              ? l10n.createOrEditOrganization_Edit
              : l10n.createOrEditOrganization_Create,
          body: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
            child: MaxWidthBox(
              maxWidth: 600,
              alignment: Alignment.center,
              child: CreateOrEditOrganizationForm(
                disabled:
                    state.status == CreateOrEditOrganizationStatus.loading,
                organizationDetails: state.organizationDetails,
                key: ValueKey(state.organizationDetails?.id),
              ),
            ),
          ),
        );
      },
    );
  }

  void _stateListener(
    BuildContext context,
    CreateOrEditOrganizationState state,
  ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == CreateOrEditOrganizationStatus.organizationSubmitted) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.edit
                  ? l10n.createOrEditOrganization_OrganizationUpdated
                  : l10n.createOrEditOrganization_OrganizationCreated,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      context.pop();
    } else if (state.status == CreateOrEditOrganizationStatus.error) {
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
    }
  }
}

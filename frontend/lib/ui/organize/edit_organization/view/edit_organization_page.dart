import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/edit_organization/cubit/edit_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/edit_organization/widgets/edit_organization_form.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/loading_indicator.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EditOrganizationPage extends StatelessWidget {
  const EditOrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: l10n.editOrganization,
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: MaxWidthBox(
          maxWidth: 600,
          alignment: Alignment.center,
          child: BlocConsumer<EditOrganizationCubit, EditOrganizationState>(
            listener: _stateListener,
            builder: (context, state) => switch (state) {
              OrganizationDetailsLoaded(:final organization, :final saving) =>
                EditOrganizationForm(
                  organization: organization,
                  disabled: saving,
                ),
              _ => const LoadingIndicator()
            },
          ),
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, EditOrganizationState state) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state case OrganizationSaved()) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.editOrganization_OrganizationUpdated,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      context.pop();
    }
  }
}

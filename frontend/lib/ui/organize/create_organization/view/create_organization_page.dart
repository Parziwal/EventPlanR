import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/create_organization/cubit/create_organization_cubit.dart';
import 'package:event_planr_app/ui/organize/create_organization/widgets/create_organization_form.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/max_width_box.dart';

class CreateOrganizationPage extends StatelessWidget {
  const CreateOrganizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: l10n.createOrganization,
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: MaxWidthBox(
          maxWidth: 600,
          alignment: Alignment.center,
          child: BlocConsumer<CreateOrganizationCubit, CreateOrganizationState>(
            listener: _stateListener,
            builder: (context, state) => CreateOrganizationForm(
              disabled: state is Loading,
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, CreateOrganizationState state) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state case OrganizationCreated()) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.createOrganizationOrganizationCreated,
              style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
            ),
            backgroundColor: theme.colorScheme.primaryContainer,
          ),
        );
      context.pop();
    }
  }
}

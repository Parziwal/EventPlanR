import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/create_or_delete_event/cubit/create_or_edit_event_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_delete_event/widgets/create_or_edit_event_form.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CreateOrEditEventPage extends StatelessWidget {
  const CreateOrEditEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: context.watch<CreateOrEditEventCubit>().state.edit
          ? l10n.createOrEditEvent_Edit
          : l10n.createOrEditEvent_Create,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: MaxWidthBox(
            maxWidth: 600,
            alignment: Alignment.center,
            child: BlocConsumer<CreateOrEditEventCubit, CreateOrEditEventState>(
              listener: _stateListener,
              builder: (context, state) => CreateOrEditEventForm(
                key: ValueKey(state.eventDetails?.id),
                eventDetails: state.eventDetails,
                disabled: state.status == CreateOrEditEventStatus.loading,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, CreateOrEditEventState state) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == CreateOrEditEventStatus.error) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              l10n.translateError(state.errorCode!),
              style: TextStyle(color: theme.colorScheme.onError),
            ),
            backgroundColor: theme.colorScheme.error,
          ),
        );
    } else if (state.status == CreateOrEditEventStatus.eventSubmitted) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.edit
                  ? l10n.createOrEditEvent_EvenUpdated
                  : l10n.createOrEditEvent_EventCreated,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      context.pop();
    }
  }
}

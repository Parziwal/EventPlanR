import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_error.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_ticket/cubit/create_or_edit_ticket_cubit.dart';
import 'package:event_planr_app/ui/organize/create_or_edit_ticket/widgets/create_or_edit_ticket_form.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/view/organize_scaffold.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CreateOrEditTicketPage extends StatelessWidget {
  const CreateOrEditTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<CreateOrEditTicketCubit,
        CreateOrEditTicketState>(
      listener: _stateListener,
      builder: (context, state) {
        return OrganizeScaffold(
          title: state.edit
              ? l10n.createOrEditTicket_EditTicket
              : l10n.createOrEditTicket_CreateTicket,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
              child: MaxWidthBox(
                maxWidth: 600,
                alignment: Alignment.center,
                child: CreateOrEditTicketForm(
                  disabled:
                  state.status == CreateOrEditTicketStatus.loading,
                  ticket: state.ticket,
                  key: ValueKey(state.ticket?.id),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _stateListener(
      BuildContext context,
      CreateOrEditTicketState state,
      ) {
    final l10n = context.l10n;
    final theme = context.theme;

    if (state.status == CreateOrEditTicketStatus.error) {
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
    } else if (state.status == CreateOrEditTicketStatus.ticketSubmitted) {
      context.scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.edit
                  ? l10n.createOrEditTicket_TicketUpdated
                  : l10n.createOrEditTicket_TicketCreated,
              style: TextStyle(color: theme.colorScheme.onPrimary),
            ),
            backgroundColor: theme.colorScheme.primary,
          ),
        );
      context.pop();
    }
  }
}

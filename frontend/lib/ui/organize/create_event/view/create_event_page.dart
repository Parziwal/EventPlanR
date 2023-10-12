import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/organize/create_event/cubit/create_event_cubit.dart';
import 'package:event_planr_app/ui/organize/create_event/widgets/create_event_form.dart';
import 'package:event_planr_app/ui/organize/organize_navbar/widgets/organize_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return OrganizeScaffold(
      title: l10n.createEvent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
          child: MaxWidthBox(
            maxWidth: 600,
            alignment: Alignment.center,
            child: BlocConsumer<CreateEventCubit, CreateEventState>(
              listener: _stateListener,
              builder: (context, state) => CreateEventForm(
                disabled: state.status == CreateEventStatus.loading,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _stateListener(BuildContext context, CreateEventState state) {}
}

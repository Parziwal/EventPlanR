import 'package:event_planr_app/app/cubit/app_cubit.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showThemePickerModal(BuildContext context) {
  final exploreCubit = context.read<AppCubit>();

  return showDialog(
    context: context,
    builder: (context) => BlocProvider.value(
      value: exploreCubit,
      child: const Dialog(
        clipBehavior: Clip.hardEdge,
        child: _ThemePickerModal(),
      ),
    ),
  );
}

class _ThemePickerModal extends StatelessWidget {
  const _ThemePickerModal();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final state = context.watch<AppCubit>().state;

    return Wrap(
      children: [
        Container(
          color: theme.colorScheme.inversePrimary,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.appSettings_ThemePicker,
              style: theme.textTheme.headlineSmall,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            children: [
              ...ThemeMode.values.map(
                (t) => ListTile(
                  onTap: () => context.read<AppCubit>().setTheme(t),
                  title: Text(
                    l10n.translateEnums(t.name),
                  ),
                  trailing:
                      state.themeMode == t ? const Icon(Icons.check) : null,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  textStyle: theme.textTheme.titleMedium,
                ),
                child: Text(
                  l10n.ok,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:event_planr_app/app/cubit/app_cubit.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/event/app_settings/widgets/language_picker_modal.dart';
import 'package:event_planr_app/ui/event/app_settings/widgets/theme_picker_modal.dart';
import 'package:event_planr_app/ui/event/event_navbar/view/event_scaffold.dart';
import 'package:event_planr_app/ui/shared/widgets/label.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/max_width_box.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return EventScaffold(
      title: l10n.appSettings,
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) => SingleChildScrollView(
          child: MaxWidthBox(
            maxWidth: 600,
            child: Column(
              children: [
                InkWell(
                  onTap: () => showThemePickerModal(context),
                  child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Label(
                        label: l10n.appSettings_Theme,
                        value: l10n.translateEnums(state.themeMode.name),
                        textStyle: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () => showLanguagePickerModal(context),
                  child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Label(
                        label: l10n.appSettings_Language,
                        value: l10n
                            .translateEnums(state.locale?.languageCode ?? ''),
                        textStyle: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

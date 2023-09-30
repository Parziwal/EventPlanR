import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';


Future<void> showFilterModal(BuildContext context) async {
  final breakpoints = context.breakpoints;

  if (breakpoints.isMobile) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (contextModal) {
        return const _FilterModal(isMobile: true);
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) {
        return const MaxWidthBox(
          maxWidth: 600,
          child: Dialog(
            clipBehavior: Clip.hardEdge,
            child: _FilterModal(isMobile: false),
          ),
        );
      },
    );
  }
}

class _FilterModal extends StatelessWidget {
  const _FilterModal({required this.isMobile, super.key});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Wrap(
      children: [
        if (isMobile) _mobileHeader(context) else _desktopHeader(context),
        SizedBox(
          height: 300,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  l10n.exploreEventsSortDirection,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  'From Date',
                  style: theme.textTheme.titleSmall,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsDate,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsAnytime,
                  style: theme.textTheme.titleSmall,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsLocation,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsAnyLocation,
                  style: theme.textTheme.titleSmall,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsLanguage,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsAnyLanguage,
                  style: theme.textTheme.titleSmall,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsCurrency,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  l10n.exploreEventsAnyCurrency,
                  style: theme.textTheme.titleSmall,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        if (!isMobile) _desktopActions(context),
      ],
    );
  }

  Widget _mobileHeader(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          Text(
            l10n.filter,
            style: theme.textTheme.titleLarge,
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
  }

  Widget _desktopHeader(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Container(
      color: theme.colorScheme.inversePrimary,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          l10n.filter,
          style: theme.textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _desktopActions(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
            ),
            child: Text(
              l10n.cancel,
            ),
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              textStyle: theme.textTheme.titleMedium,
            ),
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
  }
}

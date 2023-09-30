import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/filter_modal.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 65, child: _searchBar(context)),
          SizedBox(height: 55, child: _filterOptions(context)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);

  Widget _searchBar(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: MaxWidthBox(
        maxWidth: 600,
        child: SearchBar(
          leading: const Icon(Icons.search),
          trailing: [
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {
                showFilterModal(context);
              },
            ),
          ],
          hintText: l10n.exploreEvents,
          hintStyle: MaterialStateProperty.all(
            TextStyle(color: theme.colorScheme.outline),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _filterOptions(BuildContext context) {
    final l10n = context.l10n;
    final breakpoints = context.breakpoints;

    return Scrollbar(
      thickness: breakpoints.largerThan(MOBILE) ? null : 0,
      child: SingleChildScrollView(
        primary: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Wrap(
          spacing: 5,
          children: [
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.sort),
              label: const Text('From Date'),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.category),
              label: Text(l10n.exploreEventsAnyCategory),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.access_time),
              label: Text(l10n.exploreEventsAnytime),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_on),
              label: Text(l10n.exploreEventsAnyLocation),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.language),
              label: Text(l10n.exploreEventsAnyLanguage),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.attach_money),
              label: Text(l10n.exploreEventsAnyCurrency),
            ),
          ],
        ),
      ),
    );
  }
}

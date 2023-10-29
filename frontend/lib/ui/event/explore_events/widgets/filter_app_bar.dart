import 'dart:async';

import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/datetime_range_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_category_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_currency_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_distance_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_order_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/filter_modal.dart';
import 'package:event_planr_app/ui/shared/widgets/map_location_picker_dialog.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/max_width_box.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class FilterAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FilterAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  State<FilterAppBar> createState() => _FilterAppBarState();
}

class _FilterAppBarState extends State<FilterAppBar> {
  Timer? _debounceSearch;

  @override
  void dispose() {
    _debounceSearch?.cancel();
    super.dispose();
  }

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
          onChanged: (value) {
            if (_debounceSearch?.isActive ?? false) _debounceSearch?.cancel();
            _debounceSearch = Timer(const Duration(milliseconds: 500), () {
              context.read<ExploreEventsCubit>().filterEvents(
                    context
                        .read<ExploreEventsCubit>()
                        .state
                        .filter
                        .copyWith(searchTerm: value),
                  );
            });
          },
        ),
      ),
    );
  }

  Widget _filterOptions(BuildContext context) {
    final l10n = context.l10n;
    final breakpoints = context.breakpoints;
    final filter = context.watch<ExploreEventsCubit>().state.filter;

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
              onPressed: () => showOrderPickerModal(context),
              icon: const Icon(Icons.sort),
              label: Row(
                children: [
                  Text(l10n.translateEnums(filter.orderBy.name)),
                  if (filter.orderDirection == OrderDirectionEnum.ascending)
                    const Icon(Icons.arrow_upward),
                  if (filter.orderDirection == OrderDirectionEnum.descending)
                    const Icon(Icons.arrow_downward),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: () => showCategoryPickerModal(context),
              icon: const Icon(Icons.category),
              label: Text(
                filter.category != null
                    ? l10n.translateEnums(filter.category!.name)
                    : l10n.exploreEvents_AnyCategory,
              ),
            ),
            FilledButton.icon(
              onPressed: () => showDateTimeRangePickerModal(context),
              icon: const Icon(Icons.access_time),
              label: Text(
                filter.fromDate == null && filter.toDate == null
                    ? l10n.exploreEvents_Anytime
                    : formatDateRange(
                        filter.fromDate!,
                        filter.toDate!,
                      ),
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                showMapLocationPickerDialog(context).then((location) {
                  if (location != null) {
                    context
                        .read<ExploreEventsCubit>()
                        .getLocationAddress(location);
                  }
                });
              },
              icon: const Icon(Icons.location_on),
              label: Text(
                filter.locationName != null
                    ? filter.locationName!
                    : l10n.exploreEvents_AnyLocation,
              ),
            ),
            if (filter.locationName != null)
              FilledButton.icon(
                onPressed: () => showDistancePickerModal(context),
                icon: const Icon(Icons.social_distance),
                label: Text(
                  l10n.translateEnums(filter.distance!.name),
                ),
              ),
            FilledButton.icon(
              onPressed: () => showCurrencyPickerModal(context),
              icon: const Icon(Icons.attach_money),
              label: Text(
                filter.currency != null
                    ? l10n.translateEnums(filter.currency!.name)
                    : l10n.exploreEvents_AnyCurrency,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

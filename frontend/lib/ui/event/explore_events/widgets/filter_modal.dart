import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/domain/models/event/event_distance_enum.dart';
import 'package:event_planr_app/domain/models/event/event_filter.dart';
import 'package:event_planr_app/domain/models/event/event_order_by_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/datetime_range_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_category_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_currency_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_distance_picker_modal.dart';
import 'package:event_planr_app/ui/event/explore_events/widgets/event_order_picker_modal.dart';
import 'package:event_planr_app/ui/shared/widgets/map_location_picker_dialog.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:event_planr_app/utils/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/max_width_box.dart';

Future<void> showFilterModal(BuildContext context) async {
  final breakpoints = context.breakpoints;
  final exploreCubit = context.read<ExploreEventsCubit>();

  if (breakpoints.isMobile) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (contextModal) {
        return BlocProvider.value(
          value: exploreCubit,
          child: const _FilterModal(isMobile: true),
        );
      },
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: exploreCubit,
          child: const MaxWidthBox(
            maxWidth: 600,
            child: Dialog(
              clipBehavior: Clip.hardEdge,
              child: _FilterModal(isMobile: false),
            ),
          ),
        );
      },
    );
  }
}

class _FilterModal extends StatelessWidget {
  const _FilterModal({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final filter = context
        .watch<ExploreEventsCubit>()
        .state
        .filter;

    return Wrap(
      children: [
        if (isMobile) _mobileHeader(context) else
          _desktopHeader(context),
        SizedBox(
          height: 300,
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  l10n.exploreEvents_SortDirection,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Text(l10n.translateEnums(filter.orderBy.name)),
                    if (filter.orderDirection == OrderDirectionEnum.ascending)
                      const Icon(Icons.arrow_upward),
                    if (filter.orderDirection == OrderDirectionEnum.descending)
                      const Icon(Icons.arrow_downward),
                  ],
                ),
                onTap: () {
                  showOrderPickerModal(context);
                },
              ),
              ListTile(
                title: Text(
                  l10n.exploreEvents_Category,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  filter.category != null
                      ? l10n.translateEnums(filter.category!.name)
                      : l10n.exploreEvents_AnyCategory,
                ),
                onTap: () {
                  showCategoryPickerModal(context);
                },
              ),
              ListTile(
                title: Text(
                  l10n.exploreEvents_Date,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  filter.fromDate == null && filter.toDate == null
                      ? l10n.exploreEvents_Anytime
                      : formatDateRange(
                    filter.fromDate!,
                    filter.toDate!,
                  ),
                ),
                onTap: () {
                  showDateTimeRangePickerModal(context);
                },
              ),
              ListTile(
                title: Text(
                  l10n.exploreEvents_Location,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  filter.locationName != null
                      ? filter.locationName!
                      : l10n.exploreEvents_AnyLocation,
                ),
                onTap: () {
                  showMapLocationPickerDialog(context).then((location) {
                    if (location != null) {
                      context
                          .read<ExploreEventsCubit>()
                          .getLocationAddress(location);
                    }
                  });
                },
              ),
              if (filter.locationName != null) ...[
                ListTile(
                  title: Text(
                    l10n.exploreEvents_Distance,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  title: Text(
                    l10n.translateEnums(filter.distance!.name),
                  ),
                  onTap: () {
                    showDistancePickerModal(context);
                  },
                ),
              ],
              ListTile(
                title: Text(
                  l10n.exploreEvents_Currency,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                title: Text(
                  filter.currency != null
                      ? l10n.translateEnums(filter.currency!.name)
                      : l10n.exploreEvents_AnyCurrency,
                ),
                onTap: () {
                  showCurrencyPickerModal(context);
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
              context.read<ExploreEventsCubit>().filterEvents(
                const EventFilter(
                  orderBy: EventOrderByEnum.fromDate,
                  orderDirection: OrderDirectionEnum.descending,
                  distance: EventDistanceEnum.km10,
                  pageNumber: 1,
                ),
              );
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
              context.read<ExploreEventsCubit>().filterEvents(
                  const EventFilter(
                    orderBy: EventOrderByEnum.fromDate,
                    orderDirection: OrderDirectionEnum.descending,
                    distance: EventDistanceEnum.km10,
                    pageNumber: 1,
                  ),
              );
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

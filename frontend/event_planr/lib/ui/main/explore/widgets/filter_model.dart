import 'package:event_planr/domain/event/event.dart';
import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/ui/main/explore/widgets/category_picker.dart';
import 'package:event_planr/ui/main/explore/widgets/datetime_picker.dart';
import 'package:event_planr/ui/main/explore/widgets/distance_picker.dart';
import 'package:event_planr/ui/main/explore/widgets/location_picker.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

Future<void> showFilterModal(BuildContext context) async {
  final theme = context.theme;
  final state = context.read<ExploreCubit>().state;

  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    builder: (contextModal) {
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(contextModal),
                  child: const Text('Cancel'),
                ),
                Text(
                  'Filter',
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    context.read<ExploreCubit>().listEvents();
                    Navigator.pop(contextModal);
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    'Sort',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Date',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  title: Text(
                    state.filter.fromDate != null
                        ? '''${DateFormat.yMd().format(state.filter.fromDate!)} - ${DateFormat.yMd().format(state.filter.toDate!)}'''
                        : 'Any time',
                    style: theme.textTheme.titleSmall,
                  ),
                  onTap: () {
                    Navigator.pop(contextModal);
                    dateTimeRangePicker(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Location',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  title: Text(
                    state.placeName ?? 'Any location',
                    style: theme.textTheme.titleSmall,
                  ),
                  onTap: () {
                    Navigator.pop(contextModal);
                    locationPicker(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Distance',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  title: Text(
                    state.filter.radius != null
                        ? '${state.filter.radius! / 1000} km'
                        : 'Any distance',
                    style: theme.textTheme.titleSmall,
                  ),
                  onTap: () {
                    Navigator.pop(contextModal);
                    distancePicker(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Type',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                ListTile(
                  title: Text(
                    state.filter.category != null
                        ? EventCategory.values[state.filter.category! - 1]
                            .toString()
                            .split('.')[1]
                        : 'Any type',
                    style: theme.textTheme.titleSmall,
                  ),
                  onTap: () {
                    Navigator.pop(contextModal);
                    categoryPicker(context);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

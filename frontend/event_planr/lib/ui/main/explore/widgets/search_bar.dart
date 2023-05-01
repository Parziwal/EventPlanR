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

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = context.watch<ExploreCubit>().state;

    return SliverAppBar(
      snap: true,
      forceElevated: true,
      floating: true,
      title: TextFormField(
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 5,
            ),
          ),
          prefixIcon: const Icon(Icons.search_outlined),
          hintText: 'Explore events',
        ),
        initialValue: state.filter.searchTerm,
        onChanged: (value) => context
            .read<ExploreCubit>()
            .listEvents(filter: state.filter.copyWith(searchTerm: () => value)),
      ),
      expandedHeight: kToolbarHeight * 1.7,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight, left: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Wrap(
            spacing: 5,
            children: [
              FilledButton(
                onPressed: () => showFilterModal(context),
                child: const Icon(Icons.tune_outlined),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down),
                label: const Text('Sort'),
              ),
              FilledButton.icon(
                onPressed: () => dateTimeRangePicker(context),
                icon: const Icon(Icons.arrow_drop_down),
                label: Text(
                  state.filter.fromDate != null
                      ? '''${DateFormat.yMd().format(state.filter.fromDate!)} - ${DateFormat.yMd().format(state.filter.toDate!)}'''
                      : 'Any time',
                ),
              ),
              FilledButton.icon(
                onPressed: () => locationPicker(context),
                icon: const Icon(Icons.arrow_drop_down),
                label: state.filter.longitude != null
                    ? Text(state.placeName!)
                    : const Text('Any location'),
              ),
              FilledButton.icon(
                onPressed: () => distancePicker(context),
                icon: const Icon(Icons.arrow_drop_down),
                label: state.filter.radius != null
                    ? Text('${state.filter.radius! / 1000} km')
                    : const Text('Any distance'),
              ),
              FilledButton.icon(
                onPressed: () => categoryPicker(context),
                icon: const Icon(Icons.arrow_drop_down),
                label: Text(
                  state.filter.category != null
                      ? EventCategory.values[state.filter.category! - 1]
                          .toString()
                          .split('.')[1]
                      : 'Any type',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showDateTimeRangePickerModal(BuildContext context) async {
  final filter = context.read<ExploreEventsCubit>().state.filter;
  final picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5),
    initialDateRange: DateTimeRange(
      start: filter.fromDate != null ? filter.fromDate! : DateTime.now(),
      end: filter.toDate != null
          ? filter.toDate!
          : DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 10,
      ),
    ),
  );

  if (picked != null && context.mounted) {
    final filter = context.read<ExploreEventsCubit>().state.filter;
    unawaited(
      context.read<ExploreEventsCubit>().filterEvents(
        filter.copyWith(
          fromDate: picked.start,
          toDate: picked.end,
          pageNumber: 1,
        ),
      ),
    );
  }
}

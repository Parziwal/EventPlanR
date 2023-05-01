import 'dart:async';

import 'package:event_planr/di/injectable.dart';
import 'package:event_planr/ui/main/explore/cubit/explore_cubit.dart';
import 'package:event_planr/ui/main/explore/cubit/location_cubit.dart';
import 'package:event_planr/ui/main/explore/widgets/location_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> locationPicker(BuildContext context) async {
  final place = await showSearch(
    context: context,
    delegate: LocationSearchDelegate(
      injector<LocationCubit>(),
    ),
  );

  if (place != null && context.mounted) {
    final filter = context.read<ExploreCubit>().state.filter;
    unawaited(
      context.read<ExploreCubit>().listEvents(
            filter: filter.copyWith(
              longitude: () => place.lat,
              latitude: () => place.lon,
              radius: () => filter.radius ?? 100 * 1000,
            ),
            placeName: place.displayName,
          ),
    );
  }
}

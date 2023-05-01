import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> distancePicker(BuildContext context) {
  final theme = context.theme;
  final exploreCubit = context.read<ExploreCubit>();

  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(
      value: exploreCubit,
      child: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Distance',
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(
                height: 300,
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('5 km'),
                      trailing: state.filter.radius == 5 * 1000
                          ? const Icon(Icons.check)
                          : null,
                      onTap: () => context.read<ExploreCubit>().listEvents(
                            filter:
                                state.filter.copyWith(radius: () => 5 * 1000),
                          ),
                    ),
                    ListTile(
                      title: const Text('10 km'),
                      trailing: state.filter.radius == 10 * 1000
                          ? const Icon(Icons.check)
                          : null,
                      onTap: () => context.read<ExploreCubit>().listEvents(
                            filter:
                                state.filter.copyWith(radius: () => 10 * 1000),
                          ),
                    ),
                    ListTile(
                      title: const Text('50 km'),
                      trailing: state.filter.radius == 50 * 1000
                          ? const Icon(Icons.check)
                          : null,
                      onTap: () => context.read<ExploreCubit>().listEvents(
                            filter:
                                state.filter.copyWith(radius: () => 50 * 1000),
                          ),
                    ),
                    ListTile(
                      title: const Text('100 km'),
                      trailing: state.filter.radius == 100 * 1000
                          ? const Icon(Icons.check)
                          : null,
                      onTap: () => context.read<ExploreCubit>().listEvents(
                            filter:
                                state.filter.copyWith(radius: () => 100 * 1000),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

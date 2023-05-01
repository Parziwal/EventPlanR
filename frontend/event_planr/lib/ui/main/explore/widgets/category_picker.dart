import 'package:event_planr/domain/event/event.dart';
import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> categoryPicker(BuildContext context) {
  final theme = context.theme;
  final exploreCubit = context.read<ExploreCubit>();

  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    builder: (_) => BlocProvider.value(
      value: exploreCubit,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Category',
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: EventCategory.values.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.read<ExploreCubit>().listEvents(
                        filter: context
                            .read<ExploreCubit>()
                            .state
                            .filter
                            .copyWith(category: () => index + 1),
                      );
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text(
                    EventCategory.values[index].toString().split('.')[1],
                  ),
                  trailing:
                      context.watch<ExploreCubit>().state.filter.category ==
                              index + 1
                          ? const Icon(Icons.check)
                          : null,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:event_planr_app/domain/models/common/order_direction_enum.dart';
import 'package:event_planr_app/domain/models/event/event_order_by_enum.dart';
import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/l10n/l10n_enums.dart';
import 'package:event_planr_app/ui/event/explore_events/cubit/explore_events_cubit.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showOrderPickerModal(BuildContext context) {
  final exploreCubit = context.read<ExploreEventsCubit>();
  final breakpoints = context.breakpoints;

  if (breakpoints.isMobile) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => BlocProvider.value(
        value: exploreCubit,
        child: const _EventOrderPickerModal(
          isMobile: true,
        ),
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: exploreCubit,
        child: const Dialog(
          clipBehavior: Clip.hardEdge,
          child: _EventOrderPickerModal(
            isMobile: false,
          ),
        ),
      ),
    );
  }
}

class _EventOrderPickerModal extends StatelessWidget {
  const _EventOrderPickerModal({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final state = context.watch<ExploreEventsCubit>().state;

    return Wrap(
      children: [
        if (isMobile) _mobileHeader(context) else _desktopHeader(context),
        SizedBox(
          height: 300,
          child: ListView(
            children: [
              ...EventOrderByEnum.values.map(
                (orderBy) => Column(
                  children: [
                    ListTile(
                      onTap: () =>
                          context.read<ExploreEventsCubit>().filterEvents(
                                state.filter.copyWith(
                                  orderBy: orderBy,
                                  orderDirection: OrderDirectionEnum.ascending,
                                ),
                              ),
                      title: Row(
                        children: [
                          Text(
                            l10n.translateEnums(orderBy.name),
                          ),
                          const Icon(Icons.arrow_upward),
                        ],
                      ),
                      trailing: state.filter.orderBy == orderBy &&
                              state.filter.orderDirection ==
                                  OrderDirectionEnum.ascending
                          ? const Icon(Icons.check)
                          : null,
                    ),
                    ListTile(
                      onTap: () =>
                          context.read<ExploreEventsCubit>().filterEvents(
                                state.filter.copyWith(
                                  orderBy: orderBy,
                                  orderDirection: OrderDirectionEnum.descending,
                                ),
                              ),
                      title: Row(
                        children: [
                          Text(
                            l10n.translateEnums(orderBy.name),
                          ),
                          const Icon(Icons.arrow_downward),
                        ],
                      ),
                      trailing: state.filter.orderBy == orderBy &&
                              state.filter.orderDirection ==
                                  OrderDirectionEnum.descending
                          ? const Icon(Icons.check)
                          : null,
                    ),
                  ],
                ),
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
            l10n.exploreEvents_OrderPicker,
            style: theme.textTheme.titleLarge,
          ),
          TextButton(
            onPressed: () {
              context.read<ExploreEventsCubit>().filterEvents(
                    context.read<ExploreEventsCubit>().state.filter.copyWith(
                          orderBy: EventOrderByEnum.fromDate,
                          orderDirection: OrderDirectionEnum.descending,
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
          l10n.exploreEvents_OrderPicker,
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
                    context.read<ExploreEventsCubit>().state.filter.copyWith(
                          orderBy: EventOrderByEnum.fromDate,
                          orderDirection: OrderDirectionEnum.descending,
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

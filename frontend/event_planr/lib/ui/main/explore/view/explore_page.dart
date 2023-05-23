import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/ui/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FilterBar(),
        elevation: 2,
        toolbarHeight: 100,
      ),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<ExploreCubit, ExploreState>(
            builder: (context, state) {
              if (state.status == ExploreStatus.loading) {
                return const SliverFillRemaining(child: Loading());
              } else if (state.status == ExploreStatus.success) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => EventItem(
                      key: ValueKey(state.events[index].id),
                      event: state.events[index],
                    ),
                    childCount: state.events.length,
                  ),
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/ui/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SearchBar(),
          BlocBuilder<ExploreCubit, ExploreState>(
            builder: (context, state) {
              if (state is ExploreLoading) {
                return const SliverFillRemaining(child: Loading());
              } else if (state is ExploreEventList) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => EventItem(event: state.events[index]),
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

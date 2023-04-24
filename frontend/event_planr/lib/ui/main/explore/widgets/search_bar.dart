import 'package:event_planr/ui/main/explore/explore.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

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
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down),
                label: const Text('Any time'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down),
                label: const Text('Any location'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down),
                label: const Text('Any type'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

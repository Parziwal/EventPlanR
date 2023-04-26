import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';

Future<void> showFilterModal(BuildContext context) async {
  final theme = context.theme;

  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    builder: (context) {
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
                Text(
                  'Filter',
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
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
              'Location',
              style: theme.textTheme.titleLarge,
            ),
          ),
          ListTile(
            title: Text(
              'Type',
              style: theme.textTheme.titleLarge,
            ),
          ),
        ],
      );
    },
  );
}

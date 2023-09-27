import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
    super.key,
  });

  final Icon icon;
  final Widget label;
  final void Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ListTile(
      leading: icon,
      title: label,
      onTap: onTap,
      selectedColor: theme.colorScheme.onSurface,
      selectedTileColor: theme.colorScheme.inversePrimary,
      selected: selected,
    );
  }
}

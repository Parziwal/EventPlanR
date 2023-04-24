import 'package:event_planr/l10n/l10n.dart';
import 'package:event_planr/utils/utils.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({required this.sectionName, required this.children, super.key});

  final String sectionName;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10 = context.l10n;

    return Column(
      children: [
        Row(
          children: [
            Text(
              sectionName,
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(l10.homeSeeAll),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: children,
          ),
        ),
      ],
    );
  }
}

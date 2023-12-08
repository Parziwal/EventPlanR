import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class PercentageDataItem extends StatelessWidget {
  const PercentageDataItem({
    required this.totalCount,
    required this.count,
    required this.name,
    this.style,
    this.progressSize = 60,
    super.key,
  });

  final int totalCount;
  final int count;
  final String name;
  final TextStyle? style;
  final double? progressSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              height: progressSize,
              width: progressSize,
              child: CircularProgressIndicator(
                value: totalCount == 0 ? 0 : count / totalCount,
                color: theme.colorScheme.primaryContainer,
                backgroundColor: theme.colorScheme.primary,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  totalCount == 0
                      ? '0 %'
                      : '${(count / totalCount * 100).toStringAsFixed(1)} %',
                  style: style,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: style),
            Text('$count/$totalCount'),
          ],
        ),
      ],
    );
  }
}

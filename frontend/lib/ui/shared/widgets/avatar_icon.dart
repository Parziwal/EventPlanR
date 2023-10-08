import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class AvatarIcon extends StatelessWidget {
  const AvatarIcon({required this.altText, this.imageUrl, super.key});

  final String? imageUrl;
  final String altText;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AspectRatio(
      aspectRatio: 1,
      child: CircleAvatar(
        foregroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(altText, style: theme.textTheme.displayLarge),
          ),
        ),
      ),
    );
  }
}

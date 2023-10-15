import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class ImageWrapper extends StatelessWidget {
  const ImageWrapper({this.imageUrl, super.key});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            )
          : Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
              ),
              child: Center(
                child: Icon(
                  Icons.photo_camera,
                  color: theme.colorScheme.onSecondary,
                  size: theme.textTheme.displayLarge?.fontSize,
                ),
              ),
            ),
    );
  }
}

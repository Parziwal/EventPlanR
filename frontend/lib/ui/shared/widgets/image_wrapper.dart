import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';

class ImageWrapper extends StatelessWidget {
  const ImageWrapper({this.imageUrl, super.key});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                border: Border.all(color: theme.colorScheme.primary),
              ),
              child: Center(
                child: Text(
                  l10n.noImageFound,
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
    );
  }
}

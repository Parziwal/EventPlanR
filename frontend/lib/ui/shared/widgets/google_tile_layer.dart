import 'package:event_planr_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class GoogleTileLayer extends StatelessWidget {
  const GoogleTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TileLayer(
      urlTemplate:
      'https://{s}.google.com/vt/lyrs=m&hl={hl}&x={x}&y={y}&z={z}',
      subdomains: const ['mt0', 'mt1', 'mt2', 'mt3'],
      additionalOptions: {
        'hl': l10n.localeName,
      },
    );
  }
}

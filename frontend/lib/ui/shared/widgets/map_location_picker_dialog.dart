import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/shared/widgets/google_tile_layer.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<LatLng?> showMapLocationPickerDialog(
  BuildContext context, {
  LatLng? initialLocation,
}) {
  final breakpoints = context.breakpoints;

  return showDialog<LatLng>(
    context: context,
    builder: (context) {
      return MaxWidthBox(
        maxWidth: 1000,
        child: breakpoints.isMobile
            ? Dialog.fullscreen(
                child: _MapLocationPicker(
                  initialLocation: initialLocation,
                ),
              )
            : Dialog(
                clipBehavior: Clip.hardEdge,
                child: _MapLocationPicker(
                  initialLocation: initialLocation,
                ),
              ),
      );
    },
  );
}

class _MapLocationPicker extends StatefulWidget {
  const _MapLocationPicker({
    this.initialLocation,
  });

  final LatLng? initialLocation;

  @override
  State<_MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<_MapLocationPicker> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  void _pickLocation() {
    context.pop<LatLng>(_pickedLocation);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: widget.initialLocation ?? const LatLng(50.5, 30.51),
            initialZoom: widget.initialLocation != null ? 14 : 3,
            onTap: (_, position) => _selectLocation(position),
          ),
          children: [
            const GoogleTileLayer(),
            MarkerLayer(
              markers: [
                if (_pickedLocation != null)
                  Marker(
                    point: _pickedLocation!,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                    alignment: Alignment.topCenter,
                    width: 40,
                    height: 40,
                  ),
              ],
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: theme.colorScheme.surface,
            padding: const EdgeInsets.all(16),
            child: MaxWidthBox(
              maxWidth: 500,
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      style: FilledButton.styleFrom(
                        textStyle: theme.textTheme.titleMedium,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child:FilledButton(
                      onPressed: _pickedLocation != null ? _pickLocation : null,
                      style: FilledButton.styleFrom(
                        textStyle: theme.textTheme.titleMedium,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Text(l10n.pick),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

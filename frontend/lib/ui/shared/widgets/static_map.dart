import 'package:event_planr_app/ui/shared/widgets/google_tile_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class StaticMap extends StatelessWidget {
  const StaticMap({
    required this.location,
    this.onTap,
    super.key,
  });

  final LatLng location;
  final void Function(LatLng)? onTap;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialZoom: 14,
        initialCenter: location,
        interactionOptions: const InteractionOptions(
          enableScrollWheel: false,
          flags: InteractiveFlag.none,
        ),
        onTap: onTap != null ? (_, location) => onTap!(location) : null,
      ),
      children: [
        const GoogleTileLayer(),
        MarkerLayer(
          markers: [
            Marker(
              point: location,
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
    );
  }
}

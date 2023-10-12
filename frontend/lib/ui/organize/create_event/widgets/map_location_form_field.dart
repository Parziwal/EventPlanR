import 'package:event_planr_app/l10n/l10n.dart';
import 'package:event_planr_app/ui/shared/widgets/google_tile_layer.dart';
import 'package:event_planr_app/ui/shared/widgets/map_location_picker_dialog.dart';
import 'package:event_planr_app/utils/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:latlong2/latlong.dart';

class MapLocationFormField extends StatefulWidget {
  const MapLocationFormField({
    required this.latitudeFieldName,
    required this.longitudeFieldName,
    required this.locationPicked,
    super.key,
  });

  final String latitudeFieldName;
  final String longitudeFieldName;
  final void Function(LatLng location) locationPicked;

  @override
  State<MapLocationFormField> createState() => _MapLocationFormFieldState();
}

class _MapLocationFormFieldState extends State<MapLocationFormField> {
  final _mapController = MapController();
  final _latitudeFieldKey =
      GlobalKey<FormBuilderFieldState<FormBuilderField<String?>, String?>>();
  final _longitudeFieldKey =
      GlobalKey<FormBuilderFieldState<FormBuilderField<String?>, String?>>();
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final hasError = _latitudeFieldKey.currentState != null &&
        _longitudeFieldKey.currentState != null &&
        (_latitudeFieldKey.currentState!.hasError ||
            _longitudeFieldKey.currentState!.hasError);

    return Stack(
      children: [
        FormBuilderTextField(
          key: _latitudeFieldKey,
          name: widget.latitudeFieldName,
          valueTransformer: (value) =>
              value != null ? double.parse(value) : null,
          validator: FormBuilderValidators.compose(
            [
              (_) {
                setState(() {});
                return null;
              },
              FormBuilderValidators.required(),
            ],
          ),
        ),
        FormBuilderTextField(
          key: _longitudeFieldKey,
          name: widget.longitudeFieldName,
          enabled: false,
          valueTransformer: (value) =>
              value != null ? double.parse(value) : null,
          validator: FormBuilderValidators.compose(
            [
              (_) {
                setState(() {});
                return null;
              },
              FormBuilderValidators.required(),
            ],
          ),
        ),
        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialZoom: 1,
            interactionOptions: InteractionOptions(
              enableScrollWheel: false,
              flags: InteractiveFlag.none,
            ),
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
          bottom: 8,
          right: 8,
          child: FilledButton(
            onPressed: _pickLocation,
            child: Text(l10n.pick),
          ),
        ),
        if (hasError)
          Container(
            padding: const EdgeInsets.all(8),
            color: theme.colorScheme.error,
            child: Text(
              l10n.createEvent_LocationMustBeSet,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onError,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickLocation() async {
    final location = await showMapLocationPickerDialog(context);
    if (location != null) {
      setState(() {
        _pickedLocation = location;
        _mapController.move(location, 9);
        _latitudeFieldKey.currentState?.reset();
        _longitudeFieldKey.currentState?.reset();
        _latitudeFieldKey.currentState
            ?.setValue(location.latitude.toString());
        _longitudeFieldKey.currentState
            ?.setValue(location.longitude.toString());
      });

      widget.locationPicked(location);
    }
  }
}

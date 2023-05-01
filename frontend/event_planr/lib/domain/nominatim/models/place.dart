import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Place extends Equatable {
  const Place({
    required this.placeId,
    required this.lat,
    required this.lon,
    required this.displayName,
  });

  final int placeId;
  final double lat;
  final double lon;
  final String displayName;

  @override
  List<Object?> get props => [
        placeId,
        lat,
        lon,
        displayName,
      ];
}

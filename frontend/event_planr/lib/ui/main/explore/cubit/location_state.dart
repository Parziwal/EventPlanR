part of 'location_cubit.dart';

enum LocationStatus {
  loading,
  success,
  failure,
}

@immutable
class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStatus.loading,
    this.places = const [],
  });

  final LocationStatus status;
  final List<Place> places;

  LocationState copyWith({
    LocationStatus Function()? status,
    List<Place> Function()? places,
  }) {
    return LocationState(
      status: status != null ? status() : this.status,
      places: places != null ? places() : this.places,
    );
  }

  @override
  List<Object?> get props => [
        status,
        places,
      ];
}

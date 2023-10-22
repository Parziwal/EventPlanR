part of 'create_or_edit_event_cubit.dart';

enum CreateOrEditEventStatus { idle, loading, error, locationLoaded, eventSubmitted }

@freezed
class CreateOrEditEventState with _$CreateOrEditEventState {
  const factory CreateOrEditEventState({
    required CreateOrEditEventStatus status,
    @Default(false)
    bool edit,
    MapLocation? location,
    OrganizationEventDetails? eventDetails,
    String? errorCode,
  }) = _CreateEventState;
}

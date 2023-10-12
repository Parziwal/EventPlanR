part of 'create_event_cubit.dart';

enum CreateEventStatus { idle, loading, error, addressLoaded }

@freezed
class CreateEventState with _$CreateEventState {
  const factory CreateEventState({
    required CreateEventStatus status,
    MapAddress? address,
  }) = _CreateEventState;
}

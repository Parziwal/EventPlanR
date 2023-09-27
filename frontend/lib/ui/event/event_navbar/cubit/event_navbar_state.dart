part of 'event_navbar_cubit.dart';

@freezed
class EventNavbarState with _$EventNavbarState {
  const factory EventNavbarState.none() = _None;
  const factory EventNavbarState.appBarChanged(AppBar appBar) = _appBarChanged;
}

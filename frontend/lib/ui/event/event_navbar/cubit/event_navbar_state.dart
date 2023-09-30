part of 'event_navbar_cubit.dart';

@freezed
class EventNavbarState with _$EventNavbarState {
  const factory EventNavbarState.idle() = _Idle;
  const factory EventNavbarState.desktopTitleChanged(String title) =
      _DekstopTitleChanged;
  const factory EventNavbarState.logout() = _Logout;
}

part of 'event_navbar_cubit.dart';

@freezed
sealed class EventNavbarState with _$EventNavbarState {
  const factory EventNavbarState.idle() = Idle;
  const factory EventNavbarState.desktopTitleChanged() =
      DesktopTitleChanged;
  const factory EventNavbarState.loggedOut() = LoggedOut;
}

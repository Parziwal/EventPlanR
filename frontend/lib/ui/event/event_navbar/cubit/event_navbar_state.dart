part of 'event_navbar_cubit.dart';

enum EventNavbarStatus { idle, loggedOut }

@freezed
class EventNavbarState with _$EventNavbarState {
  const factory EventNavbarState({
    required EventNavbarStatus status,
    @Default('')
    String desktopTitle,
    User? user,
  }) = _EventNavbarState;
}

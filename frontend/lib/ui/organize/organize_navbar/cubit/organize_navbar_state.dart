part of 'organize_navbar_cubit.dart';

enum OrganizeNavbarStatus {
  idle, loggedOut
}


@freezed
class OrganizeNavbarState with _$OrganizeNavbarState {
  const factory OrganizeNavbarState({
    required OrganizeNavbarStatus status,
    @Default('')
    String desktopTitle,
    Organization? organization,
    User? user,
  }) = _OrganizeNavbarState;
}

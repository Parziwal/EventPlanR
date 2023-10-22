part of 'organize_navbar_cubit.dart';

enum OrganizeNavbarStatus {
  idle, error, loggedOut
}


@freezed
class OrganizeNavbarState with _$OrganizeNavbarState {
  const factory OrganizeNavbarState({
    required OrganizeNavbarStatus status,
    @Default('')
    String desktopTitle,
    Organization? organization,
    OrganizationEvent? event,
    User? user,
    String? errorCode,
  }) = _OrganizeNavbarState;
}

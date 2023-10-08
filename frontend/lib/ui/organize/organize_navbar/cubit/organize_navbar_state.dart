part of 'organize_navbar_cubit.dart';

enum OrganizeNavbarStatus {
  idle,
}


@freezed
class OrganizeNavbarState with _$OrganizeNavbarState {
  const factory OrganizeNavbarState({
    @Default('')
    String desktopTitle,
    Organization? organization,
  }) = _OrganizeNavbarState;
}

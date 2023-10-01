part of 'organize_navbar_cubit.dart';

@freezed
sealed class OrganizeNavbarState with _$OrganizeNavbarState {
  const factory OrganizeNavbarState.idle() = Idle;
  const factory OrganizeNavbarState.desktopTitleChanged() = DesktopTitleChanged;
}

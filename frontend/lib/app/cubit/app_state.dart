part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(ThemeMode.system)
    ThemeMode themeMode,
    Locale? locale,
  }) = _AppState;
}

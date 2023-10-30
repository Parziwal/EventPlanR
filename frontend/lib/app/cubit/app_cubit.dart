import 'package:event_planr_app/domain/app_settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_state.dart';

part 'app_cubit.freezed.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit({required AppSettingsRepository appSettingsRepository,})
      : _appSettingsRepository = appSettingsRepository,
        super(const AppState());

  final AppSettingsRepository _appSettingsRepository;

  Future<void> loadAppSettings() async {
    final theme = _appSettingsRepository.getTheme();
    final locale = _appSettingsRepository.getLanguage();

    emit(state.copyWith(themeMode: theme, locale: locale));
  }

  Future<void> setLanguage(Locale locale) async {
    await _appSettingsRepository.setLanguage(locale);
    emit(state.copyWith(locale: locale));
  }

  Future<void> setTheme(ThemeMode theme) async {
    await _appSettingsRepository.setTheme(theme);
    emit(state.copyWith(themeMode: theme));
  }
}

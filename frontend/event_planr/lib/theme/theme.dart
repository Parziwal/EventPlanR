import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: _lightColorScheme,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: _darkColorScheme,
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      useMaterial3: true,
    );
  }
}

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFB12E00),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFFFDBD1),
  onPrimaryContainer: Color(0xFF3B0900),
  secondary: Color(0xFF77574E),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFFFDBD1),
  onSecondaryContainer: Color(0xFF2C150F),
  tertiary: Color(0xFF6C5D2F),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFF6E1A6),
  onTertiaryContainer: Color(0xFF231B00),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFFFBFF),
  onBackground: Color(0xFF201A18),
  surface: Color(0xFFFFFBFF),
  onSurface: Color(0xFF201A18),
  surfaceVariant: Color(0xFFF5DED8),
  onSurfaceVariant: Color(0xFF53433F),
  outline: Color(0xFF85736E),
  onInverseSurface: Color(0xFFFBEEEB),
  inverseSurface: Color(0xFF362F2D),
  inversePrimary: Color(0xFFFFB5A0),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB12E00),
  outlineVariant: Color(0xFFD8C2BC),
  scrim: Color(0xFF000000),
);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFFFB5A0),
  onPrimary: Color(0xFF601500),
  primaryContainer: Color(0xFF872100),
  onPrimaryContainer: Color(0xFFFFDBD1),
  secondary: Color(0xFFE7BDB2),
  onSecondary: Color(0xFF442A22),
  secondaryContainer: Color(0xFF5D4037),
  onSecondaryContainer: Color(0xFFFFDBD1),
  tertiary: Color(0xFFD9C58D),
  onTertiary: Color(0xFF3B2F05),
  tertiaryContainer: Color(0xFF534619),
  onTertiaryContainer: Color(0xFFF6E1A6),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF201A18),
  onBackground: Color(0xFFEDE0DD),
  surface: Color(0xFF201A18),
  onSurface: Color(0xFFEDE0DD),
  surfaceVariant: Color(0xFF53433F),
  onSurfaceVariant: Color(0xFFD8C2BC),
  outline: Color(0xFFA08C87),
  onInverseSurface: Color(0xFF201A18),
  inverseSurface: Color(0xFFEDE0DD),
  inversePrimary: Color(0xFFB12E00),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFFFB5A0),
  outlineVariant: Color(0xFF53433F),
  scrim: Color(0xFF000000),
);

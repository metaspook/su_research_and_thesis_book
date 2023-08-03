import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom Themes for the app.
class AppThemes {
  const AppThemes._();

  static final _seedColor = ([...Colors.primaries]..shuffle()).first;

  static ThemeData _themeData({
    Brightness brightness = Brightness.light,
    Color? seedColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: seedColor ?? _seedColor,
    );
    final themeData = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(backgroundColor: colorScheme.inversePrimary),
    );

    return themeData.copyWith(
      textTheme: GoogleFonts.ubuntuTextTheme(themeData.textTheme),
    );
  }

  // Public APIs
  static ThemeData light({Color? seedColor}) =>
      _themeData(seedColor: seedColor);
  static ThemeData dark({Color? seedColor}) =>
      _themeData(brightness: Brightness.dark, seedColor: seedColor);
}

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
      // AppBar Theme

      appBarTheme: AppBarTheme(
        shape: const RoundedRectangleBorder(borderRadius: appBarBorderRadius),
        backgroundColor: colorScheme.inversePrimary.withOpacity(.75),
      ),
      // Badge Theme
      badgeTheme: BadgeThemeData(
        backgroundColor: colorScheme.primary.withOpacity(.375),
        textStyle: const TextStyle(fontWeight: FontWeight.w400),
      ),
    );

    return themeData.copyWith(
      textTheme: GoogleFonts.ubuntuTextTheme(themeData.textTheme),
    );
  }

  // Public APIs
  static const radiusCircular = Radius.circular(15);
  static const appBarBorderRadius = BorderRadius.only(
    bottomLeft: radiusCircular,
    bottomRight: radiusCircular,
  );
  static const borderRadius = BorderRadius.all(radiusCircular);
  static const outlineInputBorder = OutlineInputBorder(
    borderRadius: borderRadius,
  );

  static ThemeData light({Color? seedColor}) =>
      _themeData(seedColor: seedColor);
  static ThemeData dark({Color? seedColor}) =>
      _themeData(brightness: Brightness.dark, seedColor: seedColor);
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom Themes for the app.
sealed class AppThemes {
  static final _random = Random();

  /// Selected colors from [Colors.primaries].
  static const selectedColors = <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.blueGrey,
  ];
  static final selectedColorsRandomized = [...selectedColors]..shuffle();
  static final _seedColor = randomSelectedColor;
  static Color get randomSelectedColor {
    final randomColorIndex = _random.nextInt(selectedColors.length);
    return selectedColors[randomColorIndex];
  }

  static ThemeData _themeData({
    Brightness brightness = Brightness.light,
    Color? seedColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: seedColor ?? _seedColor,
    );
    //-- Define Theme Data.
    final themeData = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        shape: const RoundedRectangleBorder(borderRadius: bottomRadius),
        backgroundColor: colorScheme.inversePrimary.withOpacity(.75),
      ),
      // NavigationBar Theme
      navigationBarTheme: NavigationBarThemeData(
        height: kBottomNavigationBarHeight * 1.25,
        labelTextStyle: const MaterialStatePropertyAll(TextStyle()),
        iconTheme: const MaterialStatePropertyAll(
          IconThemeData(
            size: kBottomNavigationBarHeight * .5,
          ),
        ),
        backgroundColor: colorScheme.inversePrimary.withOpacity(.75),
      ),
      // Badge Theme
      badgeTheme: BadgeThemeData(
        backgroundColor: colorScheme.primary.withOpacity(.375),
        textStyle: const TextStyle(fontWeight: FontWeight.w400),
      ),
      // ListTile Theme
      listTileTheme: ListTileThemeData(
        selectedTileColor: colorScheme.outlineVariant,
      ),
      // DropdownMenu Theme
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: const InputDecorationTheme(filled: true),
        menuStyle: MenuStyle(
          visualDensity: VisualDensity.compact,
          backgroundColor: const MaterialStatePropertyAll(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
      ),
    );

    return themeData.copyWith(
      textTheme: GoogleFonts.ubuntuTextTheme(themeData.textTheme),
      // Floating Action Bar
      floatingActionButtonTheme: themeData.floatingActionButtonTheme.copyWith(
        backgroundColor: themeData.appBarTheme.backgroundColor,
      ),
      //  SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor:
            themeData.snackBarTheme.backgroundColor?.withOpacity(.25),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Public APIs
  // static double? get hintFontSize => theme.textTheme.titleMedium?.fontSize;

  static const height = 7.5;
  static const width = 7.5; // this won't always be same as the height.
  static const horizontalPadding = EdgeInsets.symmetric(horizontal: width);
  static const verticalPadding = EdgeInsets.symmetric(vertical: height);
  static const viewPadding = EdgeInsets.symmetric(
    horizontal: width,
    vertical: height,
  );

  static const circularRadius = Radius.circular(15);
  static const borderRadius = BorderRadius.all(circularRadius);
  static const topRadius = BorderRadius.only(
    topLeft: circularRadius,
    topRight: circularRadius,
  );
  static const bottomRadius = BorderRadius.only(
    bottomLeft: circularRadius,
    bottomRight: circularRadius,
  );
  static const outlineInputBorder = OutlineInputBorder(
    borderRadius: borderRadius,
  );

  static ThemeData light({Color? seedColor}) =>
      _themeData(seedColor: seedColor);
  static ThemeData dark({Color? seedColor}) =>
      _themeData(brightness: Brightness.dark, seedColor: seedColor);
}

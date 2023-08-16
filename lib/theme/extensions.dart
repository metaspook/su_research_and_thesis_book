import 'package:flutter/material.dart';

// Config
// <implement here, if any>

/// Theme related extensions.
extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

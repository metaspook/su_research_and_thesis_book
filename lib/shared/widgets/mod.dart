import 'package:flutter/material.dart';

class Mod {
  const Mod._();

  static Widget? backButton(BuildContext context) => Navigator.canPop(context)
      ? IconButton(
          onPressed: () {
            final currentFocus = FocusScope.of(context);
            currentFocus.hasPrimaryFocus == currentFocus.hasFocus
                ? Navigator.pop(context)
                : currentFocus.unfocus();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        )
      : null;
}

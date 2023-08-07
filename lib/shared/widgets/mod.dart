import 'package:flutter/material.dart';

class Mod {
  const Mod._();

  static Widget? backButton(BuildContext context) => Navigator.canPop(context)
      ? IconButton(
          onPressed: () {
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
            Future.delayed(
              const Duration(milliseconds: 250),
              () => Navigator.pop(context),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        )
      : null;
}

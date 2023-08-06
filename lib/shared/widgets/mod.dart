import 'package:flutter/material.dart';

class Mod {
  const Mod._();

  static Widget? backButton(BuildContext context) => Navigator.canPop(context)
      ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        )
      : null;
}

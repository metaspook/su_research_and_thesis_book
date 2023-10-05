import 'package:flutter/material.dart';
import 'package:su_thesis_book/l10n/l10n.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SliverAppBar(
      pinned: true,
      title: Text(l10n.homeAppBarTitle),
      centerTitle: true,
    );
  }
}

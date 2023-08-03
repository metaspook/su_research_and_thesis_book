import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/l10n/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeAppBarTitle)),
      body: Center(
        child: Text('Thesis List', style: theme.textTheme.displayLarge),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(CupertinoIcons.book),
      ),
    );
  }
}

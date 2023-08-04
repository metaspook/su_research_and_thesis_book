import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/shared.dart';

class ThesisView extends StatelessWidget {
  const ThesisView({required this.thesis, super.key});

  final Thesis thesis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(thesis.name),
      ),
      body: const Placeholder(),
    );
  }
}

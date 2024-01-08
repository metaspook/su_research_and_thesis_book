import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ResearcherListView extends StatelessWidget {
  const ResearcherListView(this.researches, {super.key});
  final List<Research> researches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppThemes.viewPadding,
      itemCount: researches.length,
      itemBuilder: (context, index) =>
          ResearchCard(researches[(researches.length - 1) - index]),
    );
  }
}

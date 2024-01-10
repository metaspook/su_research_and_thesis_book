import 'package:flutter/material.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class PublisherResearchesView extends StatelessWidget {
  const PublisherResearchesView({required this.researches, super.key});
  final List<Research> researches;

  @override
  Widget build(BuildContext context) {
    return researches.isEmpty
        ? const TranslucentLoader()
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: AppThemes.viewPadding,
            itemCount: researches.length,
            itemBuilder: (context, index) => ResearchCard(researches[index]),
          );
  }
}

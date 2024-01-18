import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class PublisherResearchesView extends StatelessWidget {
  const PublisherResearchesView({required this.publisher, super.key});
  final Publisher publisher;

  @override
  Widget build(BuildContext context) {
    final researches = context
        .select((ResearchesCubit cubit) => cubit.state.researches)
        ?.where((research) => research.publisher!.id == publisher.id)
        .toList();

    if (researches == null) return const TranslucentLoader();
    if (researches.isEmpty) return context.emptyListText();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppThemes.viewPadding,
      itemCount: researches.length,
      itemBuilder: (context, index) => ResearchCard(researches[index]),
    );
  }
}

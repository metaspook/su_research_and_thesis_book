import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef ResearchesBlocSelector<T>
    = BlocSelector<ResearchesCubit, ResearchesState, T>;
typedef ResearchesBlocListener = BlocListener<ResearchesCubit, ResearchesState>;

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

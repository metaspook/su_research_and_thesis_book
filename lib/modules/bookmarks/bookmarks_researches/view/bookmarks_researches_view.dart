import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class BookmarksResearchesView extends StatelessWidget {
  const BookmarksResearchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final researchIds = context
        .select((BookmarksResearchesCubit cubit) => cubit.state.researchIds);
    final researches = context
        .select((ResearchesCubit cubit) => cubit.state.researches)
        ?.where((e) => researchIds.contains(e.id))
        .toList();

    return researches == null
        ? const TranslucentLoader()
        : researches.isEmpty
            ? context.emptyListText()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: AppThemes.viewPadding,
                itemCount: researches.length,
                itemBuilder: (context, index) =>
                    ResearchCard(researches[index]),
              );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class BookmarksResearchesView extends StatelessWidget {
  const BookmarksResearchesView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookmarksCubit>().getViewIndex(1);
    final cubit = context.read<BookmarksResearchesCubit>();
    final isLoading = context.select(
        (BookmarksResearchesCubit cubit) => cubit.state.status.isLoading);
    final researches = context
        .select((BookmarksResearchesCubit cubit) => cubit.state.researches);
    final researchBookmarks = context.select(
      (BookmarksResearchesCubit cubit) => cubit.state.researchBookmarks,
    );
    final selectedResearches = context.select(
      (BookmarksResearchesCubit cubit) => cubit.state.selectedResearches,
    );

    final selectedResearchesIsEmpty = selectedResearches.isEmpty;

    return researches == null || isLoading
        ? const TranslucentLoader()
        : researches.isEmpty
            ? context.emptyListText()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: AppThemes.viewPadding,
                itemCount: researches.length,
                itemBuilder: (context, index) {
                  final research = researches[index];
                  return ResearchCard(
                    research,
                    selected: selectedResearches.contains(research),
                    onTap: selectedResearchesIsEmpty
                        ? null
                        : () => cubit.onSelectionToggled(research),
                    onLongPress: () => cubit.onSelectionToggled(research),
                  );
                },
              );
  }
}

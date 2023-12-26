import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class BookmarksResearchesAppBar extends StatelessWidget {
  const BookmarksResearchesAppBar({
    required this.tabBar,
    super.key,
    this.researches,
  });
  final TabBar tabBar;
  final List<Research>? researches;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksResearchesCubit>();
    final researches = context
        .select((BookmarksResearchesCubit cubit) => cubit.state.researches);
    final selectedResearches = context.select(
      (BookmarksResearchesCubit cubit) => cubit.state.selectedResearches,
    );
    final selectedResearchesIsEmpty = selectedResearches.isEmpty;
    final researchesNullOrEmpty = researches == null || researches.isEmpty;

    return context.sliverAppBar(
      context.l10n.bookmarkAppBarTitle,
      centerTitle: false,
      bottom: tabBar,
      actions: [
        // Select All button.
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: researchesNullOrEmpty || researches == selectedResearches
              ? null
              : cubit.onAllSelected,
          iconSize: kToolbarHeight * .575,
          icon: const Icon(
            Icons.select_all_rounded,
          ),
        ),
        // Deselect All button.
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: selectedResearchesIsEmpty ? null : cubit.onAllDeselected,
          iconSize: kToolbarHeight * .575,
          icon: const Icon(
            Icons.deselect_rounded,
          ),
        ),
        // Remove button.
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: selectedResearchesIsEmpty ? null : cubit.onRemoved,
          iconSize: kToolbarHeight * .575,
          icon: Icon(
            selectedResearchesIsEmpty
                ? Icons.remove_circle_outline_rounded
                : Icons.remove_circle_rounded,
          ),
        ),
      ],
    );
  }
}

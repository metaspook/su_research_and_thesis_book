import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef BookmarksBlocSelector<T>
    = BlocSelector<BookmarksCubit, BookmarksState, T>;

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<BookmarksCubit>();
    final selectedTheses =
        context.select((BookmarksCubit cubit) => cubit.state.selectedTheses);
    final selectedThesesIsEmpty = selectedTheses.isEmpty;
    final theses = context.select((BookmarksCubit cubit) => cubit.state.theses);
    final thesesIsEmpty = theses.isEmpty;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar(
            l10n.bookmarkAppBarTitle,
            centerTitle: false,
            actions: [
              // Select All button.
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: thesesIsEmpty || theses == selectedTheses
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
                onPressed: selectedThesesIsEmpty ? null : cubit.onAllDeselected,
                iconSize: kToolbarHeight * .575,
                icon: const Icon(
                  Icons.deselect_rounded,
                ),
              ),
              // Remove button.
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: selectedThesesIsEmpty
                    ? null
                    : theses == selectedTheses
                        ? cubit.onAllRemoved
                        : cubit.onRemoved,
                iconSize: kToolbarHeight * .575,
                icon: Icon(
                  selectedThesesIsEmpty
                      ? Icons.remove_circle_outline_rounded
                      : Icons.remove_circle_rounded,
                ),
              ),
            ],
          ),
        ],
        body: ListView.builder(
          padding: AppThemes.viewPadding,
          physics: const BouncingScrollPhysics(),
          itemCount: theses.length,
          itemBuilder: (context, index) {
            final thesis = theses[index];
            return ThesisCard(
              thesis,
              selected: selectedTheses.contains(thesis),
              onTap: selectedThesesIsEmpty
                  ? null
                  : () => cubit.onSelectionToggled(thesis),
              onLongPress: () => cubit.onSelectionToggled(thesis),
            );
          },
        ),
      ),
    );
  }
}

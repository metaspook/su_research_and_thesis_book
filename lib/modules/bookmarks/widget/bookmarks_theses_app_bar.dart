import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class BookmarksThesesAppBar extends StatelessWidget {
  const BookmarksThesesAppBar({
    required this.tabBar,
    super.key,
    this.theses,
  });
  final TabBar tabBar;
  final List<Thesis>? theses;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksThesesCubit>();
    final theses =
        context.select((BookmarksThesesCubit cubit) => cubit.state.theses);
    final selectedTheses = context
        .select((BookmarksThesesCubit cubit) => cubit.state.selectedTheses);
    final selectedThesesIsEmpty = selectedTheses.isEmpty;
    final thesesNullOrEmpty = theses == null || theses.isEmpty;

    return context.sliverAppBar(
      context.l10n.bookmarkAppBarTitle,
      centerTitle: false,
      bottom: tabBar,
      actions: [
        // Select All button.
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: thesesNullOrEmpty || theses == selectedTheses
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
    );
  }
}

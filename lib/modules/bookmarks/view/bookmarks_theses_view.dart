import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class BookmarksThesesView extends StatelessWidget {
  const BookmarksThesesView({super.key});
  // final List<Thesis>? theses;

  @override
  Widget build(BuildContext context) {
    context.read<BookmarksCubit>().getViewIndex(0);
    final cubit = context.read<BookmarksThesesCubit>();
    final theses =
        context.select((BookmarksThesesCubit cubit) => cubit.state.theses);
    final selectedTheses = context
        .select((BookmarksThesesCubit cubit) => cubit.state.selectedTheses);
    final selectedThesesIsEmpty = selectedTheses.isEmpty;

    return theses == null
        ? const TranslucentLoader()
        : theses.isEmpty
            ? context.emptyListText()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: AppThemes.viewPadding,
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
              );
  }
}

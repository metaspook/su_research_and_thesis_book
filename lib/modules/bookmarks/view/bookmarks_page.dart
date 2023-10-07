import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef BookmarksBlocSelector<T>
    = BlocSelector<BookmarksCubit, BookmarksState, T>;

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookmarksCubit>();
    final l10n = context.l10n;
    const thesis = Thesis(id: 'id', userId: 'userId');
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar(l10n.bookmarkAppBarTitle, [
            BookmarksBlocSelector<bool>(
              selector: (state) => state.selectedTheses.isEmpty,
              builder: (context, selectedThesesIsEmpty) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: selectedThesesIsEmpty ? null : cubit.onRemoved,
                  iconSize: kToolbarHeight * .575,
                  icon: Icon(
                    selectedThesesIsEmpty
                        ? Icons.remove_circle_outline_rounded
                        : Icons.remove_circle_rounded,
                  ),
                );
              },
            ),
          ]),
        ],
        body: BookmarksBlocSelector<List<Thesis>>(
          selector: (state) => state.theses,
          builder: (context, theses) {
            return ListView.builder(
              padding: AppThemes.viewPadding,
              physics: const BouncingScrollPhysics(),
              itemCount: theses.length,
              itemBuilder: (context, index) {
                return ThesisCard(
                  theses[index],
                  selected: cubit.isSelected(thesis),
                  onLongPress: () => cubit.onSelected(thesis),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class BookmarksThesesView extends StatelessWidget {
  const BookmarksThesesView({super.key});

  @override
  Widget build(BuildContext context) {
    final thesisIds =
        context.select((BookmarksCubit cubit) => cubit.state.thesisIds);
    final theses = context
        .select((ThesesCubit cubit) => cubit.state.theses)
        ?.where((e) => thesisIds.contains(e.id))
        .toList();

    return theses == null
        ? const TranslucentLoader()
        : theses.isEmpty
            ? context.emptyListText()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: AppThemes.viewPadding,
                itemCount: theses.length,
                itemBuilder: (context, index) => ThesisCard(theses[index]),
              );
  }
}

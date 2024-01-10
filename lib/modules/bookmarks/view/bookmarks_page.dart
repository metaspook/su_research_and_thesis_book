import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/modules/bookmarks/bookmarks.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

// typedef BookmarksBlocSelector<T>
//     = BlocSelector<BookmarksResearchesCubit, BookmarksResearchesState, T>;

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewIndex = context.select((BookmarksCubit cubit) => cubit.state);
    const tabBar = TabBar(
      splashBorderRadius: AppThemes.borderRadius,
      tabs: [Tab(text: 'Thesis'), Tab(text: 'Researches')],
    );

    return DefaultTabController(
      length: tabBar.tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            [
              const BookmarksThesesAppBar(tabBar: tabBar),
              const BookmarksResearchesAppBar(tabBar: tabBar),
            ][viewIndex],
          ],
          body: const TabBarView(
            children: [
              BookmarksThesesView(),
              BookmarksResearchesView(),
            ],
          ),
        ),
      ),
    );
  }
}

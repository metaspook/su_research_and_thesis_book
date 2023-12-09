import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef ResearchesBlocSelector<T>
    = BlocSelector<ResearchesCubit, ResearchesState, T>;
typedef ResearchesBlocListener = BlocListener<ResearchesCubit, ResearchesState>;

class PublisherResearchesView extends StatelessWidget {
  const PublisherResearchesView({super.key});

  @override
  Widget build(BuildContext context) {
    var researches =
        context.select((HomeCubit cubit) => cubit.state.researches);
    final isLoading =
        context.select((ResearchesCubit cubit) => cubit.state.status.isLoading);
    // Handle Null and Empty cases.
    if (researches == null || isLoading) return const TranslucentLoader();
    if (researches.isEmpty) return context.emptyListText();
    // Handle search query string.
    final search =
        context.select((ResearchesCubit cubit) => cubit.state.search);
    researches = search.isEmpty
        ? researches
        : [
            ...researches.where(
              (element) => element.title.toStringParseNull().contains(search),
            ),
          ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppThemes.viewPadding,
      itemCount: researches.length,
      itemBuilder: (context, index) => ResearchCard(researches![index]),
    );
  }
}

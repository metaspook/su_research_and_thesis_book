import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/modules/home/home.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

typedef ResearchesNavBlocSelector<T>
    = BlocSelector<ResearchesCubit, ResearchesState, T>;
typedef ResearchesNavBlocListener
    = BlocListener<ResearchesCubit, ResearchesState>;

class ResearchesNavView extends StatelessWidget {
  const ResearchesNavView({super.key});

  @override
  Widget build(BuildContext context) {
    var researches =
        context.select((ResearchesCubit cubit) => cubit.state.researches);
    // Handle Null and Empty cases.
    if (researches == null) return const TranslucentLoader();
    if (researches.isEmpty) return context.emptyListText();
    // Handle search query string.
    final search =
        context.select((ResearchesNavCubit cubit) => cubit.state.search);
    researches = search.isEmpty
        ? researches
        : [
            ...researches.where(
              (research) => research.title.toStringParseNull().contains(search),
            ),
          ];
    return ResearcherListView(researches);
  }
}

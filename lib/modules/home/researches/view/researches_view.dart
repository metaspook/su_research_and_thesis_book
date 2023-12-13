import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef ResearchesBlocSelector<T>
    = BlocSelector<ResearchesCubit, ResearchesState, T>;
typedef ResearchesBlocListener = BlocListener<ResearchesCubit, ResearchesState>;

class ResearchesView extends StatelessWidget {
  const ResearchesView({super.key});

  @override
  Widget build(BuildContext context) {
    var researches = context.select((AppCubit cubit) => cubit.state.researches);
    // Handle Null and Empty cases.
    if (researches == null) return const TranslucentLoader();
    if (researches.isEmpty) return context.emptyListText();
    // Handle search query string.
    final search =
        context.select((ResearchesCubit cubit) => cubit.state.search);
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/modules/home/home.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

typedef ThesesNavBlocSelector<T> = BlocSelector<ThesesCubit, ThesesState, T>;
typedef ThesesNavBlocListener = BlocListener<ThesesCubit, ThesesState>;

class ThesesNavView extends StatelessWidget {
  const ThesesNavView({super.key});

  @override
  Widget build(BuildContext context) {
    var theses = context.select((ThesesCubit cubit) => cubit.state.theses);
    // Handle Null and Empty cases.
    if (theses == null) return const TranslucentLoader();
    if (theses.isEmpty) return context.emptyListText();
    // Handle search query string.
    final search = context.select((ThesesNavCubit cubit) => cubit.state.search);
    theses = search.isEmpty
        ? theses
        : [
            ...theses.where(
              (thesis) => thesis.title.toStringParseNull().contains(search),
            ),
          ];
    return ThesesListView(theses);
  }
}

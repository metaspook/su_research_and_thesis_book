import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef ThesesBlocSelector<T> = BlocSelector<ThesesCubit, ThesesState, T>;
typedef ThesesBlocListener = BlocListener<ThesesCubit, ThesesState>;

class ThesesView extends StatelessWidget {
  const ThesesView({super.key});

  @override
  Widget build(BuildContext context) {
    var theses = context.select((AppCubit cubit) => cubit.state.theses);
    // Handle Null and Empty cases.
    if (theses == null) return const TranslucentLoader();
    if (theses.isEmpty) return context.emptyListText();
    // Handle search query string.
    final search = context.select((ThesesCubit cubit) => cubit.state.search);
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

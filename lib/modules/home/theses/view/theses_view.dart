import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ThesesView extends StatelessWidget {
  const ThesesView({super.key});

  @override
  Widget build(BuildContext context) {
    var theses = context.select((HomeCubit cubit) => cubit.state.theses);
    final isLoading =
        context.select((ThesesCubit cubit) => cubit.state.status.isLoading);
    // Handle Null and Empty cases.
    if (theses == null || isLoading) return const TranslucentLoader();
    if (theses.isEmpty) return context.emptyListText();
    // Handle search query string.
    final search = context.select((ThesesCubit cubit) => cubit.state.search);
    theses = search.isEmpty
        ? theses
        : [
            ...theses.where(
              (element) => element.name.toStringParseNull().contains(search),
            ),
          ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppThemes.viewPadding,
      itemCount: theses.length,
      itemBuilder: (context, index) => ThesisCard(theses![index]),
    );
  }
}

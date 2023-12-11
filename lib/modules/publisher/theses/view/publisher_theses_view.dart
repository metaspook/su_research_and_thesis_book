import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef ThesesBlocSelector<T> = BlocSelector<ThesesCubit, ThesesState, T>;
typedef ThesesBlocListener = BlocListener<ThesesCubit, ThesesState>;

class PublisherThesesView extends StatelessWidget {
  const PublisherThesesView({required this.theses, super.key});
  final List<Thesis> theses;

  @override
  Widget build(BuildContext context) {
    // final theses = context.select((AppCubit cubit) => cubit.state.theses);
    // final isLoading =
    //     context.select((ThesesCubit cubit) => cubit.state.status.isLoading);
    // Handle Null and Empty cases.
    // if (theses == null) return const TranslucentLoader();
    // if (theses.isEmpty) return context.emptyListText();
    // // Handle search query string.
    // final search = context.select((ThesesCubit cubit) => cubit.state.search);
    // theses = search.isEmpty
    //     ? theses
    //     : [
    //         ...theses.where(
    //           (element) => element.title.toStringParseNull().contains(search),
    //         ),
    //       ];

    return theses.isEmpty
        ? const TranslucentLoader()
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: AppThemes.viewPadding,
            itemCount: theses.length,
            itemBuilder: (context, index) => ThesisCard(theses[index]),
          );
  }
}

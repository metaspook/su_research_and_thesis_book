import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ThesesView extends StatelessWidget {
  const ThesesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theses = context.select((HomeCubit cubit) => cubit.state.theses);
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

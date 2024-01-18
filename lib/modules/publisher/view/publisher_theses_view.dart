import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class PublisherThesesView extends StatelessWidget {
  const PublisherThesesView({required this.publisher, super.key});
  final Publisher publisher;

  @override
  Widget build(BuildContext context) {
    final theses = context
        .select((ThesesCubit cubit) => cubit.state.theses)
        ?.where((thesis) => thesis.publisher!.id == publisher.id)
        .toList();

    if (theses == null) return const TranslucentLoader();
    if (theses.isEmpty) return context.emptyListText();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppThemes.viewPadding,
      itemCount: theses.length,
      itemBuilder: (context, index) => ThesisCard(theses[index]),
    );
  }
}

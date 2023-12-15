import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class PublisherThesesView extends StatelessWidget {
  const PublisherThesesView({required this.theses, super.key});
  final List<Thesis> theses;

  @override
  Widget build(BuildContext context) {
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

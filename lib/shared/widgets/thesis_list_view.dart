import 'package:flutter/material.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ThesesListView extends StatelessWidget {
  const ThesesListView(this.theses, {super.key});
  final List<Thesis> theses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: AppThemes.viewPadding,
      itemCount: theses.length,
      itemBuilder: (context, index) =>
          ThesisCard(theses[(theses.length - 1) - index]),
    );
  }
}

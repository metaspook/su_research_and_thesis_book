import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/modules/thesis_entry/thesis_entry.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class ThesisEntriesView extends StatelessWidget {
  const ThesisEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThesisEntriesCubit>();
    final isLoading = context.select(
      (ThesisEntriesCubit cubit) => cubit.state.status.isLoading,
    );
    final userId = context.select((AppCubit cubit) => cubit.state.user.id);
    final theses = context
        .select((ThesesCubit cubit) => cubit.state.thesesOfPublisher(userId));
    final selectedTheses = context
        .select((ThesisEntriesCubit cubit) => cubit.state.selectedTheses);
    final selectedThesesIsEmpty = selectedTheses.isEmpty;

    return theses == null || isLoading
        ? const TranslucentLoader()
        : theses.isEmpty
            ? context.emptyListText()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: AppThemes.viewPadding,
                itemCount: theses.length,
                itemBuilder: (context, index) {
                  final thesis = theses[(theses.length - 1) - index];
                  return ThesisCard(
                    thesis,
                    selected: selectedTheses.contains(thesis),
                    onTap: selectedThesesIsEmpty
                        ? null
                        : () => cubit.onSelectionToggled(thesis),
                    onLongPress: () => cubit.onSelectionToggled(thesis),
                  );
                },
              );
  }
}

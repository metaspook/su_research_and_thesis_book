import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ResearchEntriesView extends StatelessWidget {
  const ResearchEntriesView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ResearchEntryCubit>().setView(1);
    final cubit = context.read<ResearchEntriesCubit>();
    final isLoading = context.select(
      (ResearchEntriesCubit cubit) => cubit.state.status.isLoading,
    );
    final userId = context.select((AppCubit cubit) => cubit.state.user.id);
    final researches = context.select(
      (ResearchesCubit cubit) => cubit.state.researchesOfPublisher(userId),
    );

    final selectedResearches = context
        .select((ResearchEntriesCubit cubit) => cubit.state.selectedResearches);
    final selectedResearchesIsEmpty = selectedResearches.isEmpty;

    return researches == null || isLoading
        ? const TranslucentLoader()
        : researches.isEmpty
            ? context.emptyListText()
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: AppThemes.viewPadding,
                itemCount: researches.length,
                itemBuilder: (context, index) {
                  final research = researches[index];
                  return ResearchCard(
                    research,
                    selected: selectedResearches.contains(research),
                    onTap: selectedResearchesIsEmpty
                        ? null
                        : () => cubit.onSelectionToggled(research),
                    onLongPress: () => cubit.onSelectionToggled(research),
                  );
                },
              );
  }
}

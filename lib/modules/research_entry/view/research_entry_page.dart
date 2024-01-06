import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef ResearchEntryBlocSelector<T> = BlocSelector<ResearchEntryCubit, int, T>;
// typedef ResearchEntryBlocListener = BlocListener<ResearchEntryCubit, int>;

class ResearchEntryPage extends StatelessWidget {
  const ResearchEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResearchEntryCubit>();
    const tabs = [Tab(text: 'New Entry'), Tab(text: 'Entries')];
    final researchEntriesCubit = context.read<ResearchEntriesCubit>();
    final selectedResearches = context
        .select((ResearchEntriesCubit cubit) => cubit.state.selectedResearches);
    final selectedResearchesIsEmpty = selectedResearches.isEmpty;
    final userId = context.select((AppCubit cubit) => cubit.state.user.id);
    final researches = context.select(
      (ResearchesCubit cubit) => cubit.state.researchesOfPublisher(userId),
    );
    final researchesNullOrEmpty = researches == null || researches.isEmpty;

    return ResearchNewEntryBlocListener(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == ResearchNewEntryStatus.success,
      listener: (context, state) => context.pop(),
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              ResearchEntryBlocSelector<bool>(
                selector: (state) => state == 0,
                builder: (context, isNewEntry) {
                  return context.sliverAppBar(
                    context.l10n.researchEntryAppBarTitle,
                    centerTitle: false,
                    bottom: TabBar(
                      onTap: cubit.setView,
                      splashBorderRadius: AppThemes.borderRadius,
                      tabs: tabs,
                    ),
                    actions: [
                      // Select All button.
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: isNewEntry ||
                                researchesNullOrEmpty ||
                                researches == selectedResearches
                            ? null
                            : () =>
                                researchEntriesCubit.onAllSelected(researches),
                        iconSize: kToolbarHeight * .575,
                        icon: const Icon(
                          Icons.select_all_rounded,
                        ),
                      ),
                      // Deselect All button.
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: isNewEntry || selectedResearchesIsEmpty
                            ? null
                            : researchEntriesCubit.onAllDeselected,
                        iconSize: kToolbarHeight * .575,
                        icon: const Icon(
                          Icons.deselect_rounded,
                        ),
                      ),
                      // Remove button.
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: isNewEntry || selectedResearchesIsEmpty
                            ? null
                            : researchEntriesCubit.onRemoved,
                        iconSize: kToolbarHeight * .575,
                        icon: Icon(
                          selectedResearchesIsEmpty
                              ? Icons.remove_circle_outline_rounded
                              : Icons.remove_circle_rounded,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
            body: const TabBarView(
              children: [ResearchNewEntryView(), ResearchEntriesView()],
            ),
          ),
        ),
      ),
    );
  }
}

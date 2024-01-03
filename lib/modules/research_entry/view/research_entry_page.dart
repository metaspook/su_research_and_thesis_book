import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

// typedef ResearchEntryBlocSelector<T>
//     = BlocSelector<ResearchEntryCubit, ResearchEntryState, T>;
// typedef ResearchEntryBlocListener
//     = BlocListener<ResearchEntryCubit, ResearchEntryState>;

class ResearchEntryPage extends StatelessWidget {
  const ResearchEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final researchEntriesCubit = context.read<ResearchEntriesCubit>();
    final selectedResearches = context
        .select((ResearchEntriesCubit cubit) => cubit.state.selectedResearches);
    final selectedResearchesIsEmpty = selectedResearches.isEmpty;
    final userId = context.select((AppCubit cubit) => cubit.state.user.id);
    final researches = context.select(
      (ResearchesCubit cubit) => cubit.state.researchesOfPublisher(userId),
    );

    final researchesNullOrEmpty = researches == null || researches.isEmpty;

    const tabBar = TabBar(
      splashBorderRadius: AppThemes.borderRadius,
      tabs: [Tab(text: 'New Entry'), Tab(text: 'Entries')],
    );

    // ResearchEntryBlocListener(
    //   listenWhen: (previous, current) =>
    //       previous.statusMsg != current.statusMsg,
    //   listener: (context, state) {
    //     final snackBar = SnackBar(
    //       clipBehavior: Clip.none,
    //       content: Text(state.statusMsg!),
    //     );
    //     context.scaffoldMessenger.showSnackBar(snackBar);
    //   },
    // ),
    // ResearchEntryBlocListener(
    //   listenWhen: (previous, current) =>
    //       current.status == ResearchEntryStatus.success,
    //   listener: (context, state) => context.pop(),
    // ),

    return DefaultTabController(
      length: tabBar.tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            BlocSelector<ResearchEntryCubit, int, bool>(
              selector: (state) => state == 0,
              builder: (context, isNewEntry) {
                return context.sliverAppBar(
                  context.l10n.researchEntryAppBarTitle,
                  centerTitle: false,
                  bottom: tabBar,
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
            children: [
              ResearchNewEntryView(),
              ResearchEntriesView(),
            ],
          ),
        ),
      ),
    );
  }
}

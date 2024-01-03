import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/thesis_entry/thesis_entry.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

// typedef ThesisEntryBlocSelector<T>
//     = BlocSelector<ThesisEntryCubit, ThesisEntryState, T>;
// typedef ThesisEntryBlocListener
//     = BlocListener<ThesisEntryCubit, ThesisEntryState>;

class ThesisEntryPage extends StatelessWidget {
  const ThesisEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final thesisEntriesCubit = context.read<ThesisEntriesCubit>();
    final selectedTheses = context
        .select((ThesisEntriesCubit cubit) => cubit.state.selectedTheses);
    final selectedThesesIsEmpty = selectedTheses.isEmpty;
    final userId = context.select((AppCubit cubit) => cubit.state.user.id);
    final theses = context
        .select((ThesesCubit cubit) => cubit.state.thesesOfPublisher(userId));

    final thesesNullOrEmpty = theses == null || theses.isEmpty;

    const tabBar = TabBar(
      splashBorderRadius: AppThemes.borderRadius,
      tabs: [Tab(text: 'New Entry'), Tab(text: 'Entries')],
    );

    // ThesisEntryBlocListener(
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
    // ThesisEntryBlocListener(
    //   listenWhen: (previous, current) =>
    //       current.status == ThesisEntryStatus.success,
    //   listener: (context, state) => context.pop(),
    // ),

    return DefaultTabController(
      length: tabBar.tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            BlocSelector<ThesisEntryCubit, int, bool>(
              selector: (state) => state == 0,
              builder: (context, isNewEntry) {
                return context.sliverAppBar(
                  context.l10n.thesisEntryAppBarTitle,
                  centerTitle: false,
                  bottom: tabBar,
                  actions: [
                    // Select All button.
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: isNewEntry ||
                              thesesNullOrEmpty ||
                              theses == selectedTheses
                          ? null
                          : () => thesisEntriesCubit.onAllSelected(theses),
                      iconSize: kToolbarHeight * .575,
                      icon: const Icon(
                        Icons.select_all_rounded,
                      ),
                    ),
                    // Deselect All button.
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: isNewEntry || selectedThesesIsEmpty
                          ? null
                          : thesisEntriesCubit.onAllDeselected,
                      iconSize: kToolbarHeight * .575,
                      icon: const Icon(
                        Icons.deselect_rounded,
                      ),
                    ),
                    // Remove button.
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: isNewEntry || selectedThesesIsEmpty
                          ? null
                          : thesisEntriesCubit.onRemoved,
                      iconSize: kToolbarHeight * .575,
                      icon: Icon(
                        selectedThesesIsEmpty
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
              ThesisNewEntryView(),
              ThesisEntriesView(),
            ],
          ),
        ),
      ),
    );
  }
}

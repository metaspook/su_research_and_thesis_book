import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ResearchesAppBar extends StatefulWidget {
  const ResearchesAppBar({super.key});

  @override
  State<ResearchesAppBar> createState() => _ResearchesAppBarState();
}

class _ResearchesAppBarState extends State<ResearchesAppBar> {
  // TextEditingControllers
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TextEditingControllers
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResearchesCubit>();
    final l10n = context.l10n;
    final searchMode =
        context.select((ResearchesCubit cubit) => cubit.state.searchMode);

    return context.sliverAppBar(
      l10n.researchesAppBarTitle,
      bottom: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.5,
          vertical: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: searchMode
                  ? SearchBar(
                      onChanged: cubit.onChangedSearch,
                      elevation: const MaterialStatePropertyAll(0),
                      hintText: 'Search here...',
                      shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: AppThemes.borderRadius,
                        ),
                      ),
                    )
                  : ResearchesBlocSelector<List<String>?>(
                      selector: (state) => state.categories,
                      builder: (context, categories) {
                        final department = context.select(
                          (ResearchesCubit cubit) => cubit.state.category,
                        );
                        final departmentAll = const ResearchesState().category;

                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            menuMaxHeight: AppThemes.menuMaxHeight,
                            padding: AppThemes.viewPadding,
                            value: department,
                            borderRadius: AppThemes.borderRadius,
                            hint: const Text('department...'),
                            items: [
                              DropdownMenuItem(
                                value: departmentAll,
                                child: Text(departmentAll),
                              ),
                              if (categories != null)
                                for (final department in categories)
                                  DropdownMenuItem(
                                    value: department,
                                    child: Text(department),
                                  ),
                            ],
                            onChanged: cubit.onChangedCategory,
                          ),
                        );
                      },
                    ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: cubit.toggleSearch,
              iconSize: kToolbarHeight * .575,
              icon: Icon(
                searchMode ? Icons.cancel_rounded : Icons.search_rounded,
              ),
            ),
          ],
        ),
      ).withToolbarHeight().toPreferredSize(),
    );
  }
}

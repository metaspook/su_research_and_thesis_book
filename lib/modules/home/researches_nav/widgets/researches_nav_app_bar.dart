import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/l10n/l10n.dart';
import 'package:su_research_and_thesis_book/modules/home/home.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class ResearchesNavAppBar extends StatefulWidget {
  const ResearchesNavAppBar({super.key});

  @override
  State<ResearchesNavAppBar> createState() => _ResearchesNavAppBarState();
}

class _ResearchesNavAppBarState extends State<ResearchesNavAppBar> {
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
    final cubit = context.read<ResearchesNavCubit>();
    final l10n = context.l10n;
    final searchMode =
        context.select((ResearchesNavCubit cubit) => cubit.state.searchMode);

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
                  : CategoriesBlocSelector<List<String>?>(
                      selector: (state) => state.categories,
                      builder: (context, categories) {
                        final category = context.select(
                          (ResearchesNavCubit cubit) => cubit.state.category,
                        );
                        final categoryAll = const ResearchesNavState().category;

                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            menuMaxHeight: AppThemes.menuMaxHeight,
                            padding: AppThemes.viewPadding,
                            value: category,
                            borderRadius: AppThemes.borderRadius,
                            items: [
                              DropdownMenuItem(
                                value: categoryAll,
                                child: Text(categoryAll),
                              ),
                              if (categories != null)
                                for (final category in categories)
                                  DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
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

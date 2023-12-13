import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ThesesAppBar extends StatefulWidget {
  const ThesesAppBar({super.key});

  @override
  State<ThesesAppBar> createState() => _ThesesAppBarState();
}

class _ThesesAppBarState extends State<ThesesAppBar> {
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
    final cubit = context.read<ThesesCubit>();
    final l10n = context.l10n;
    final searchMode =
        context.select((ThesesCubit cubit) => cubit.state.searchMode);

    return context.sliverAppBar(
      l10n.thesesAppBarTitle,
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
                  : AppBlocSelector<List<String>?>(
                      selector: (state) => state.departments,
                      builder: (context, departments) {
                        final department = context.select(
                          (ThesesCubit cubit) => cubit.state.department,
                        );
                        final departmentAll = const ThesesState().department;

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
                              if (departments != null)
                                for (final department in departments)
                                  DropdownMenuItem(
                                    value: department,
                                    child: Text(department),
                                  ),
                            ],
                            onChanged: cubit.onChangedDepartment,
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

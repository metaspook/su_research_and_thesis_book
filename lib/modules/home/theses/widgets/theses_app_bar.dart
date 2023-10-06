import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
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

    return SliverAppBar(
      pinned: true,
      title: Text(l10n.thesesAppBarTitle),
      centerTitle: true,
      actions: [
        if (searchMode)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.5,
                vertical: 6,
              ),
              child: SearchBar(
                onChanged: cubit.onChangedSearch,
                elevation: const MaterialStatePropertyAll(0),
                hintText: 'Search here...',
                shape: const MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: AppThemes.borderRadius,
                  ),
                ),
              ),
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
    );
  }
}

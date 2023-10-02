import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

typedef HomeBlocSelector<T> = BlocSelector<HomeCubit, HomeState, T>;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final l10n = context.l10n;
    const viewRecords = [
      (
        label: 'Home',
        icon: Icons.home_rounded,
        view: HomeView(),
      ),
      (
        label: 'Bookmark',
        icon: Icons.bookmark_rounded,
        view: HomeView(),
      ),
    ];

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // AppBar
          SliverAppBar(
            pinned: true,
            title: Text(l10n.homeAppBarTitle),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 4.5),
                child: GestureDetector(
                  onTap: () => context.push(AppRouter.profile.path),
                  child: AppBlocSelector<String?>(
                    selector: (state) => state.user.photoUrl,
                    builder: (context, photoUrl) {
                      return HaloAvatar(photoUrl);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
        body: HomeBlocSelector<int>(
          selector: (state) => state.viewIndex,
          builder: (context, viewIndex) => viewRecords[viewIndex].view,
        ),

        // Builder(
        //   builder: (context) {
        //     final isLoading = context
        //         .select((HomeCubit cubit) => cubit.state.status.isLoading);
        //     final theses =
        //         context.select((HomeCubit cubit) => cubit.state.theses);

        //     return theses.isEmpty
        //         ? Center(
        //             child: Text(
        //               'No Thesis!',
        //               style: context.theme.textTheme.displayMedium,
        //             ),
        //           )
        //         : TranslucentLoader(
        //             enabled: isLoading,
        //             child: ListView.builder(
        //               physics: const BouncingScrollPhysics(),
        //               padding: const EdgeInsets.all(5),
        //               itemCount: theses.length,
        //               itemBuilder: (context, index) {
        //                 return ThesisCard(theses[index]);
        //               },
        //             ),
        //           );
        //   },
        // ),
      ),
      bottomNavigationBar: HomeBlocSelector<int>(
        selector: (state) => state.viewIndex,
        builder: (context, selectedIndex) => NavigationBar(
          height: kBottomNavigationBarHeight * 1.25,
          selectedIndex: selectedIndex,
          onDestinationSelected: cubit.onDestinationSelected,
          destinations: [
            for (final viewRecord in viewRecords)
              NavigationDestination(
                icon: Icon(viewRecord.icon),
                label: viewRecord.label,
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Thesis'),
        icon: const Icon(Icons.playlist_add_outlined),
        onPressed: () => ThesisEntryDialog.show(context),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef HomeBlocSelector<T> = BlocSelector<HomeCubit, HomeState, T>;
// typedef ThesesBlocSelector<T> = BlocSelector<ThesesCubit, ThesesState, T>;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final l10n = context.l10n;
    final viewRecords = [
      (
        label: 'Home',
        title: l10n.homeAppBarTitle,
        icon: Icons.home_rounded,
        view: const HomeView(),
      ),
      (
        label: 'Theses',
        title: 'Browse Theses',
        icon: Icons.folder_rounded,
        view: BlocProvider<ThesesCubit>(
          create: (context) =>
              ThesesCubit(thesisRepo: context.read<ThesisRepo>()),
          child: const ThesesView(),
        ),
      ),
    ];

    return Scaffold(
      body: HomeBlocSelector<int>(
        selector: (state) => state.viewIndex,
        builder: (context, viewIndex) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              // AppBar
              SliverAppBar(
                pinned: true,
                title: Text(viewRecords[viewIndex].title),
                centerTitle: true,
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.only(right: 4.5),
                //     child: GestureDetector(
                //       onTap: () => context.push(AppRouter.profile.path),
                //       child: AppBlocSelector<String?>(
                //         selector: (state) => state.user.photoUrl,
                //         builder: (context, photoUrl) {
                //           return HaloAvatar(photoUrl);
                //         },
                //       ),
                //     ),
                //   ),
                // ],
              ),
            ],
            body: viewRecords[viewIndex].view,
          );
        },
      ),
      extendBody: true,
      bottomNavigationBar: HomeBlocSelector<int>(
        selector: (state) => state.viewIndex,
        builder: (context, selectedIndex) => ClipRRect(
          borderRadius: AppThemes.topRadius,
          child: NavigationBar(
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

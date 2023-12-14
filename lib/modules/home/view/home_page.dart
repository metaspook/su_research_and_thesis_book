import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class HomeCubit extends Cubit<int> {
  HomeCubit() : super(1);
  void onDestinationSelected(int index) => emit(index);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final viewRecords = [
      (
        label: 'Theses',
        icon: Icons.folder_rounded,
        appBar: const ThesesNavAppBar(),
        view: const ThesesNavView(),
      ),
      (
        label: 'Home',
        icon: Icons.home_rounded,
        appBar: context.sliverAppBar(l10n.homeAppBarTitle),
        view: const HomeView(),
      ),
      (
        label: 'Researches',
        icon: Icons.folder_rounded,
        appBar: const ResearchesNavAppBar(),
        view: const ResearchesNavView(),
      ),
    ];
    final cubit = context.read<HomeCubit>();
    final viewIndex = context.select((HomeCubit cubit) => cubit.state);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [viewRecords[viewIndex].appBar],
        body: viewRecords[viewIndex].view,
      ),
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: AppThemes.topRadius,
        child: NavigationBar(
          selectedIndex: viewIndex,
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
    );
  }
}

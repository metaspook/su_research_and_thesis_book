import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int viewIndex = 1;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

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
          onDestinationSelected: (index) => setState(() => viewIndex = index),
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

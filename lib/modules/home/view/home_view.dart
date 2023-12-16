import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final theses = context.select((HomeCubit cubit) => cubit.state.theses);
    // final researches =
    //     context.select((HomeCubit cubit) => cubit.state.researches);
    final iconButtonRecords = <IconButtonRecord>[
      (
        label: 'Bookmarks',
        icon: Icons.bookmark_rounded,
        onPressed: AppRouter.bookmarks.name == null
            ? null
            : () => context.pushNamed(AppRouter.bookmarks.name!),
      ),
      (
        label: 'Publishers',
        icon: Icons.group_rounded,
        onPressed: () => context.pushNamed(AppRouter.publishers.name!),
      ),
      (
        label: 'Notifications',
        icon: Icons.notifications_rounded,
        onPressed: () {},
      ),
      (
        label: 'Thesis Entry',
        icon: Icons.upload_file_rounded,
        onPressed: AppRouter.thesisEntry.name == null
            ? null
            : () => context.pushNamed(AppRouter.thesisEntry.name!),
      ),
      (
        label: 'Profile',
        icon: Icons.person_rounded,
        onPressed: AppRouter.profile.name == null
            ? null
            : () => context.pushNamed(AppRouter.profile.name!),
      ),
      (
        label: 'Research Entry',
        icon: Icons.upload_file_rounded,
        onPressed: AppRouter.researchEntry.name == null
            ? null
            : () => context.pushNamed(AppRouter.researchEntry.name!),
      ),
    ];
    final theses = context.select((ThesesCubit cubit) => cubit.state.theses);

    return theses == null
        ? const TranslucentLoader()
        : ListView(
            padding: AppThemes.verticalPadding * 2,
            children: [
              ThesisCarousel(theses),
              const SizedBox(height: AppThemes.height * 4.5),
              const ProfileCarousel(),
              GridView.count(
                padding: AppThemes.verticalPadding,
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.425,
                children: [
                  for (var i = 0; i < iconButtonRecords.length; i++)
                    IconButtonLabeled(
                      iconButtonRecords[i],
                      color: AppThemes.selectedColors[i],
                      size: context.mediaQuery.size.shortestSide * .09,
                    ),
                ],
              ),
            ],
          );
  }
}

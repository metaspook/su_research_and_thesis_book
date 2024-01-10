import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/modules/home/home.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final theses = context.select((HomeCubit cubit) => cubit.state.theses);
    // final researches =
    //     context.select((HomeCubit cubit) => cubit.state.researches);
    final isStudent = context
        .select((AppCubit cubit) => cubit.state.user.designation == 'Student');
    final iconButtonRecords = <IconButtonRecord>[
      (
        label: 'Bookmarks',
        color: Colors.cyan,
        icon: Icons.bookmark_rounded,
        onPressed: AppRouter.bookmarks.name == null
            ? null
            : () => context.pushNamed(AppRouter.bookmarks.name!),
      ),
      (
        label: 'Publishers',
        icon: Icons.group_rounded,
        color: Colors.pink,
        onPressed: () => context.pushNamed(AppRouter.publishers.name!),
      ),
      (
        label: 'Notifications',
        icon: Icons.notifications_rounded,
        color: Colors.amber,
        // onPressed: () {},
        onPressed: () => context.pushNamed(AppRouter.notifications.name!),
      ),
      (
        label: 'Thesis Entry',
        icon: Icons.upload_file_rounded,
        color: Colors.orange,
        onPressed: () => isStudent
            ? context.showNotAllowedDialog()
            : context.pushNamed(AppRouter.thesisEntry.name!),
      ),
      (
        label: 'Profile',
        icon: Icons.person_rounded,
        color: Colors.blue,
        onPressed: AppRouter.profile.name == null
            ? null
            : () => context.pushNamed(AppRouter.profile.name!),
      ),
      (
        label: 'Research Entry',
        icon: Icons.upload_file_rounded,
        color: Colors.green,
        onPressed: () => isStudent
            ? context.showNotAllowedDialog()
            : context.pushNamed(AppRouter.researchEntry.name!),
      ),
    ];
    final theses = context.select((ThesesCubit cubit) => cubit.state.theses);
    final researches =
        context.select((ResearchesCubit cubit) => cubit.state.researches);
    final thesisPublishers =
        context.select((ThesesCubit cubit) => cubit.state.publishers);
    final researchPublishers =
        context.select((ResearchesCubit cubit) => cubit.state.publishers);

    return theses == null || researches == null
        ? const TranslucentLoader()
        : ListView(
            padding: AppThemes.verticalPadding * 2,
            children: [
              ThesisCarousel(
                theses: theses.reversed.toList(),
                researches: researches.reversed.toList(),
              ),
              const SizedBox(height: AppThemes.height * 4.5),
              ProfileCarousel(
                publishers: [
                  if (thesisPublishers != null) ...thesisPublishers,
                  if (researchPublishers != null) ...researchPublishers,
                ],
              ),
              GridView.count(
                padding: AppThemes.verticalPadding,
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1.425,
                children: [
                  for (var i = 0; i < iconButtonRecords.length; i++)
                    if (i == 2)
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Positioned(
                            top: 12.5,
                            right: 22.5,
                            child: BlocSelector<NotificationsCubit,
                                NotificationsState, int>(
                              selector: (state) => state.notifications.length,
                              builder: (context, notificationsCount) {
                                return Badge.count(
                                  count: notificationsCount,
                                  backgroundColor: Colors.transparent,
                                  largeSize: 20,
                                  textColor: context
                                      .theme.colorScheme.inversePrimary
                                      .withOpacity(.85),
                                  textStyle: context.theme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ),
                          IconButtonLabeled(
                            iconButtonRecords[i],
                            size: context.mediaQuery.size.shortestSide * .09,
                          ),
                        ],
                      )
                    else
                      IconButtonLabeled(
                        iconButtonRecords[i],
                        size: context.mediaQuery.size.shortestSide * .09,
                      ),
                ],
              ),
            ],
          );
  }
}

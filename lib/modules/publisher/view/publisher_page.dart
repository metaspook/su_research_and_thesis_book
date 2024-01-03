import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/publisher/publisher.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class PublisherPage extends StatelessWidget {
  const PublisherPage({required this.publisher, super.key});
  final Publisher publisher;

  @override
  Widget build(BuildContext context) {
    final theses = context.select((ThesesCubit cubit) => cubit.state.theses);
    final researches =
        context.select((ResearchesCubit cubit) => cubit.state.researches);
    const tabBar = TabBar(
      splashBorderRadius: AppThemes.borderRadius,
      tabs: [Tab(text: 'Thesis'), Tab(text: 'Researches')],
    );

    return DefaultTabController(
      length: tabBar.tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            context.sliverAppBar(
              'Publisher',
              expandedHeight: kToolbarHeight * 4.125,
              bottom: tabBar,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    const SizedBox(height: kTextTabBarHeight * 1.75),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HaloAvatar(publisher.photoUrl, size: 2),
                        Column(
                          children: [
                            Text(
                              publisher.name.toStringParseNull(),
                              style: context.theme.textTheme.titleLarge,
                            ),
                            Text(publisher.designation.toStringParseNull()),
                            Text(publisher.department.toStringParseNull()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              PublisherThesesView(theses: theses ?? []),
              PublisherResearchesView(researches: researches ?? []),
            ],
          ),
        ),
      ),
    );
  }
}

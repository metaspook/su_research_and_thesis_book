import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    const CommentsRepo().fetchComments().then(print);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(l10n.homeAppBarTitle),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 4.5),
                child: GestureDetector(
                  onTap: () {},
                  child: const HaloAvatar(),
                ),
              ),
            ],
          )
        ],
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(5),
          itemCount: 10,
          itemBuilder: (context, index) {
            final thesis = Thesis(
              name: 'Thesis Name',
              author: 'Riad',
              createdAt: DateTime.now(),
            );

            return ThesisCard(thesis);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(CupertinoIcons.book),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // const CommentsRepo().fetchComments().then(print);

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
                  onTap: () => context.push(AppRouter.profile.path),
                  child: const HaloAvatar(
                    imagePath:
                        'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_kids_avatar_user_profile_icon_149314.png',
                  ),
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Thesis'),
        icon: const Icon(Icons.menu_book_rounded),
        onPressed: () {
          ThesisEntryDialog.show(context);
        },
      ),
    );
  }
}

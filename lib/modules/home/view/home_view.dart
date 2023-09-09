import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

typedef AppBlocSelector<T> = BlocSelector<AppCubit, AppState, T>;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // const CommentsRepo().fetchComments().then(print);

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
                      return HaloAvatar(url: photoUrl);
                    },
                  ),
                ),
              ),
            ],
          ),
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
        icon: const Icon(Icons.playlist_add_outlined),
        onPressed: () {
          ThesisEntryDialog.show(context);
        },
      ),
    );
  }
}

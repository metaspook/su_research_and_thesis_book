import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef HomeBlocSelector<T> = BlocSelector<HomeCubit, HomeState, T>;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
        body: Builder(
          builder: (context) {
            final isLoading = context
                .select((HomeCubit cubit) => cubit.state.status.isLoading);
            final theses =
                context.select((HomeCubit cubit) => cubit.state.theses);

            return theses.isEmpty
                ? Center(
                    child: Text(
                      'No Thesis!',
                      style: context.theme.textTheme.displayMedium,
                    ),
                  )
                : TranslucentLoader(
                    enabled: isLoading,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(5),
                      itemCount: theses.length,
                      itemBuilder: (context, index) {
                        return ThesisCard(theses[index]);
                      },
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Thesis'),
        icon: const Icon(Icons.playlist_add_outlined),
        onPressed: () => ThesisEntryDialog.show(context),
      ),
    );
  }
}

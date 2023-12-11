import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/modules/publisher/publisher.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef SignInBlocSelector<T> = BlocSelector<SignInBloc, SignInState, T>;
typedef SignInBlocListener = BlocListener<SignInBloc, SignInState>;
typedef SignInBlocConsumer = BlocConsumer<SignInBloc, SignInState>;
typedef SignUpBlocSelector<T> = BlocSelector<SignUpBloc, SignUpState, T>;
typedef SignUpBlocListener = BlocListener<SignUpBloc, SignUpState>;
typedef SignUpBlocConsumer = BlocConsumer<SignUpBloc, SignUpState>;

class PublisherPage extends StatelessWidget {
  const PublisherPage({required this.publisher, super.key});
  final Publisher publisher;

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AuthPage());
  }

  @override
  Widget build(BuildContext context) {
    final theses = context.select(
      (AppCubit cubit) => cubit.state.theses,
    );
    final researches =
        context.select((AppCubit cubit) => cubit.state.researches);
    const tabBar = TabBar(
      splashBorderRadius: AppThemes.borderRadius,
      tabs: [Tab(text: 'Thesis'), Tab(text: 'Researches')],
    );

    return DefaultTabController(
      length: tabBar.tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            context.sliverAppBar('Publisher', bottom: tabBar),
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

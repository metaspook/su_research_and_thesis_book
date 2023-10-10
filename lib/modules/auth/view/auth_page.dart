import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef SignInBlocSelector<T> = BlocSelector<SignInBloc, SignInState, T>;
typedef SignInBlocListener = BlocListener<SignInBloc, SignInState>;
typedef SignInBlocConsumer = BlocConsumer<SignInBloc, SignInState>;
typedef SignUpBlocSelector<T> = BlocSelector<SignUpBloc, SignUpState, T>;
typedef SignUpBlocListener = BlocListener<SignUpBloc, SignUpState>;
typedef SignUpBlocConsumer = BlocConsumer<SignUpBloc, SignUpState>;

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AuthPage());
  }

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(
      splashBorderRadius: AppThemes.borderRadius,
      tabs: [
        ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: AppThemes.bottomRadius,
          child: Tab(text: 'Sign in'),
        ),
        Tab(text: 'Sign up'),
      ],
    );

    return DefaultTabController(
      length: tabBar.tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            context.sliverAppBar(
              'Authentication 🔐',
              centerTitle: false,
              bottom: tabBar,
            ),
          ],
          body: const TabBarView(
            children: [SignInView(), SignUpView()],
          ),
        ),
      ),
    );
  }
}

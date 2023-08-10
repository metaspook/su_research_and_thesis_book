import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/modules.dart';
import 'package:su_thesis_book/shared/shared.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(tabs: [Tab(text: 'Sign in'), Tab(text: 'Sign up')]);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Authentication 🔐'),
          // centerTitle: true,
          // ClipRRect to match the border radius wth AppBar
          bottom: const ClipRRect(
            borderRadius: AppThemes.appBarBorderRadius,
            child: tabBar,
          ).toPreferredSize(tabBar.preferredSize),
        ),
        body: RepositoryProvider<ImageRepo>(
          create: (context) => ImageRepo(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SignUpBloc>(
                create: (context) => SignUpBloc(),
              )
            ],
            child: const TabBarView(
              children: [SignInView(), SignUpView()],
            ),
          ),
        ),
      ),
    );
  }
}

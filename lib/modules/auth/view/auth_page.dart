import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AuthPage());
  }

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(tabs: [Tab(text: 'Sign in'), Tab(text: 'Sign up')]);

    return DefaultTabController(
      initialIndex: 1,
      length: tabBar.tabs.length,
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
        body: const TabBarView(
          children: [SignInView(), SignUpView()],
        ),
      ),
    );
  }
}

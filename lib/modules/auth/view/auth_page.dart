import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/modules/auth/auth.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove splash screen.
    FlutterNativeSplash.remove();
    const tabBar = TabBar(
      splashBorderRadius: AppThemes.borderRadius,
      tabs: [Tab(text: 'Sign in'), Tab(text: 'Sign up')],
    );

    return DefaultTabController(
      length: tabBar.tabs.length,
      child: AppBlocListener(
        listenWhen: (previous, current) =>
            previous.firstLaunch && current.firstLaunch,
        listener: (context, state) => context.showLandingDialog(),
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
      ),
    );
  }
}

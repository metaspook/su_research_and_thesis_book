// part of 'app_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

export 'package:go_router/go_router.dart' show GoRouterHelper;

final class AppRoutes {
  final router = GoRouter(
    initialLocation: '/profile',
    routes: <RouteBase>[
      root,
      home,
      profile,
    ],
  );

  static final root = GoRoute(
    path: '/',
    builder: (context, state) {
      return RepositoryProvider<ImageRepo>(
        create: (context) => const ImageRepo(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SignUpBloc>(
              create: (context) =>
                  SignUpBloc(imageRepo: context.read<ImageRepo>()),
            ),
          ],
          child: const AuthPage(),
        ),
      );
    },
  );
  static final home = GoRoute(
    path: '/home',
    builder: (context, state) {
      return const HomePage();
    },
  );
  static final profile = GoRoute(
    path: '/profile',
    builder: (context, state) {
      return const ProfilePage();
    },
  );
}

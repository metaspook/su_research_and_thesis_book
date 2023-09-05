// part of 'app_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

// Exposes routing interface for view.
export 'package:go_router/go_router.dart' show GoRouterHelper;

final class AppRouter {
  //-- Register routes
  final config = GoRouter(
    // navigatorKey: ,
    // initialLocation: home.path,
    // initialLocation: auth.path,
    routes: <RouteBase>[
      // root,
      home,
      auth,
      profile,
    ],
    redirect: (context, state) {
      final status = context.watch<AppCubit>().state.status;
      return switch (status) {
        AppStatus.authenticated => '/',
        _ => '/auth',
      };
    },
    // redirect: (context, state) {
    //   final status = context.watch<AppCubit>().state.status;
    //   final isAuthenticated = status == AppStatus.authenticated;
    //   return isAuthenticated ? '/' : '/auth';
    // },
  );

  //-- Define routes
  // Home
  static final home = GoRoute(
    name: 'home',
    path: '/',
    // redirect: (context, state) {
    //   final status = context.watch<AppCubit>().state.status;
    //   return switch (status) {
    //     AppStatus.authenticated => '/',
    //     _ => '/auth',
    //   };
    // },
    builder: (context, state) {
      return const HomePage();
    },
  );
  // Auth
  static final auth = GoRoute(
    name: 'auth',
    path: '/auth',
    // redirect: (context, state) {
    //   final status = context.watch<AppCubit>().state.status;
    //   final isAuthenticated = status == AppStatus.authenticated;
    //   return isAuthenticated ? '/' : null;
    // },
    builder: (context, state) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepo>(
            create: (context) => const AuthRepo(),
          ),
          RepositoryProvider<AppUserRepo>(
            create: (context) => const AppUserRepo(),
          ),
          RepositoryProvider<RoleRepo>(
            create: (context) => const RoleRepo(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                authRepo: context.read<AuthRepo>(),
              ),
            ),
            BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(
                authRepo: context.read<AuthRepo>(),
                appUserRepo: context.read<AppUserRepo>(),
                roleRepo: context.read<RoleRepo>(),
              )..add(const SignUpFormLoaded()),
            ),
          ],
          child: const AuthPage(),
        ),
      );
    },
  );
  // Profile
  static final profile = GoRoute(
    name: 'profile',
    path: '/profile',
    builder: (context, state) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepo>(
            create: (context) => const AuthRepo(),
          ),
          RepositoryProvider<AppUserRepo>(
            create: (context) => const AppUserRepo(),
          ),
          RepositoryProvider<RoleRepo>(
            create: (context) => const RoleRepo(),
          ),
        ],
        child: BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            authRepo: context.read<AuthRepo>(),
            appUserRepo: context.read<AppUserRepo>(),
            roleRepo: context.read<RoleRepo>(),
          ),
          child: const ProfilePage(),
        ),
      );
    },
  );
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

// Exposes routing interface for views.
export 'package:go_router/go_router.dart' show GoRouterHelper;

final class AppRouter {
  AppRouter({this.initialLocation, this.navigatorKey})
      : config = GoRouter(
          //-- Register routes
          routes: <RouteBase>[
            home,
            auth,
            profile,
          ],
          initialLocation: initialLocation,
          navigatorKey: navigatorKey,
        );

  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialLocation;
  final GoRouter config;

  //-- Define routes
  // Home
  static final home = GoRoute(
    name: 'home',
    path: '/',
    // redirect: _redirect,
    builder: (context, state) {
      return const HomePage();
    },
  );
  // Auth
  static final auth = GoRoute(
    name: 'auth',
    path: '/auth',
    // redirect: _redirect,
    builder: (context, state) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepo>(
            create: (context) => AuthRepo(),
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
            create: (context) => AuthRepo(),
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
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(
                authRepo: context.read<AuthRepo>(),
              ),
            ),
            BlocProvider<ProfileUpdateBloc>(
              create: (context) => ProfileUpdateBloc(
                authRepo: context.read<AuthRepo>(),
                appUserRepo: context.read<AppUserRepo>(),
              ),
            ),
          ],
          child: const ProfilePage(),
        ),
      );
    },
  );

  // static FutureOr<String?> _redirect(
  //   BuildContext context,
  //   GoRouterState state,
  // ) {
  //   // AppStatus prevStatus;
  //   final status = context.watch<AppCubit>().state.status;
  //   'Path: ${state.path}, isAuthenticated: ${status.isAuthenticated}'.doPrint();
  //   if (state.path == '/auth' && status.isAuthenticated) {
  //     return '/';
  //   } else if (state.path != '/auth' && status.isUnauthenticated) {
  //     return '/auth';
  //   }

  //   return null;
  // }
}

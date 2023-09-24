import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/modules/thesis/cubit/thesis_cubit.dart';
import 'package:su_thesis_book/modules/thesis/thesis.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

// Exposes routing interface for views.
export 'package:go_router/go_router.dart' show GoRoute, GoRouterHelper;

final class AppRouter {
  // AppRouter({this.initialLocation, this.navigatorKey})
  AppRouter({this.initialLocation})
      : config = GoRouter(
          //-- Register routes
          routes: <RouteBase>[home, auth, profile],
          initialLocation: initialLocation,
          // navigatorKey: navigatorKey,
        );

  // final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialLocation;
  final GoRouter config;

  //-- Define routes
  // Home
  static final home = GoRoute(
    name: 'home',
    path: '/',
    // redirect: _redirect,
    builder: (context, state) {
      return RepositoryProvider<ThesisRepo>(
        create: (context) => ThesisRepo(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(
                thesisRepo: context.read<ThesisRepo>(),
              ),
            ),
            BlocProvider<ThesisEntryCubit>(
              create: (context) => ThesisEntryCubit(
                thesisRepo: context.read<ThesisRepo>(),
              ),
            ),
          ],
          child: const HomePage(),
        ),
      );
    },
    routes: <RouteBase>[thesis],
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

  // Thesis
  static final thesis = GoRoute(
    name: 'thesis',
    path: 'thesis',
    builder: (context, state) {
      'Current Route: ${state.fullPath}'.doPrint();
      final thesis = state.extra! as Thesis;
      return RepositoryProvider<ThesisRepo>(
        create: (context) => ThesisRepo(),
        child: BlocProvider<ThesisCubit>(
          create: (context) => ThesisCubit(
            thesisRepo: context.read<ThesisRepo>(),
            thesis: thesis,
          )..incrementViews(thesis),
          child: ThesisPage(thesis: thesis),
        ),
      );
    },
    routes: <RouteBase>[comments],
  );

  // Comments
  static final comments = GoRoute(
    name: 'comments',
    path: 'comments',
    builder: (context, state) {
      'Current Route: ${state.fullPath}'.doPrint();
      final thesis = state.extra! as Thesis;
      return RepositoryProvider<CommentRepo>(
        create: (context) => CommentRepo(thesisId: thesis.id),
        child: BlocProvider<CommentsCubit>(
          create: (context) => CommentsCubit(
            commentRepo: context.read<CommentRepo>(),
          ),
          child: CommentsPage(thesis: thesis),
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

extension GoRouteExt on GoRoute {
  String get pathUnderRoot => '/$path';
}

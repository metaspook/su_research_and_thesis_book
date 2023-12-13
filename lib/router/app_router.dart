part of 'router.dart';

final class AppRouter {
  // AppRouter({this.initialLocation, this.navigatorKey})
  AppRouter({this.initialLocation})
      : config = GoRouter(
          //-- Register routes
          routes: <RouteBase>[
            home,
            auth,
            profile,
            bookmarks,
            thesisEntry,
            passwordReset,
            publishers,
            publisher,
          ],
          initialLocation: initialLocation,
          // navigatorKey: navigatorKey,
          // redirect: (context, state) {
          //   // AppStatus prevStatus;
          //   final status = context.watch<AppCubit>().state.status;
          //   'Path: ${state.path}, isAuthenticated: ${status.isAuthenticated}'
          //       .doPrint();
          //   return status.isAuthenticated ? null : '/auth';
          // },
        ) {
    config.routeInformationProvider.value.uri.doPrint('Current Route: ');
  }

  // final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialLocation;
  final GoRouter config;

  //-- Define routes
  // Home
  static final home = GoRoute(
    name: 'home',
    path: '/',
    // redirect: _redirect,
    routes: <RouteBase>[thesis],
    builder: (context, state) {
      return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ThesisRepo>(
            create: (context) => ThesisRepo(),
          ),
          RepositoryProvider<ResearchRepo>(
            create: (context) => ResearchRepo(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
            ),
            BlocProvider<ThesesCubit>(
              create: (context) => ThesesCubit(),
              child: const ThesesView(),
            ),
            BlocProvider<ResearchesCubit>(
              create: (context) => ResearchesCubit(
                appUserRepo: context.read<AppUserRepo>(),
                categoryRepo: context.read<CategoryRepo>(),
                researchRepo: context.read<ResearchRepo>(),
              ),
              child: const ResearchesView(),
            ),
          ],
          child: const HomePage(),
        ),
      );
    },
  );
  // Auth
  static final auth = GoRoute(
    name: 'auth',
    path: '/auth',
    // redirect: _redirect,
    builder: (context, state) {
      return MultiBlocProvider(
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
              designationRepo: context.read<DesignationRepo>(),
              departmentRepo: context.read<DepartmentRepo>(),
            ),
          ),
        ],
        child: const AuthPage(),
      );
    },
  );

  // Profile
  static final profile = GoRoute(
    name: 'profile',
    path: '/profile',
    builder: (context, state) {
      return MultiBlocProvider(
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
      );
    },
  );

  // Publishers
  static final publishers = GoRoute(
    name: 'publishers',
    path: '/publishers',
    builder: (context, state) {
      return const PublishersPage();
    },
  );

  // Publisher
  static final publisher = GoRoute(
    name: 'publisher',
    path: '/publisher',
    builder: (context, state) {
      final publisher = state.extra! as Publisher;
      return PublisherPage(publisher: publisher);
    },
  );

  // Thesis
  static final thesis = GoRoute(
    name: 'thesis',
    path: 'thesis',
    builder: (context, state) {
      final thesis = state.extra! as Thesis;
      return RepositoryProvider<ThesisRepo>(
        create: (context) => ThesisRepo(),
        child: BlocProvider<ThesisCubit>(
          create: (context) => ThesisCubit(
            thesisRepo: context.read<ThesisRepo>(),
            thesis: thesis,
          ),
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

  // Bookmarks
  static final bookmarks = GoRoute(
    name: 'bookmarks',
    path: '/bookmarks',
    builder: (context, state) {
      'Current Route: ${state.fullPath}'.doPrint();
      return RepositoryProvider<ThesisRepo>(
        create: (context) => ThesisRepo(),
        child: BlocProvider<BookmarksCubit>(
          create: (context) => BookmarksCubit(
            thesisRepo: context.read<ThesisRepo>(),
          ),
          child: const BookmarksPage(),
        ),
      );
    },
  );

  // Thesis Entry
  static final thesisEntry = GoRoute(
    name: 'thesisEntry',
    path: '/thesis_entry',
    builder: (context, state) {
      'Current Route: ${state.fullPath}'.doPrint();
      return RepositoryProvider<ThesisRepo>(
        create: (context) => ThesisRepo(),
        child: BlocProvider<ThesisEntryCubit>(
          create: (context) => ThesisEntryCubit(
            thesisRepo: context.read<ThesisRepo>(),
          ),
          child: const ThesisEntryPage(),
        ),
      );
    },
  );

  // Thesis Entry
  static final passwordReset = GoRoute(
    name: 'passwordReset',
    path: '/password_reset',
    builder: (context, state) {
      'Current Route: ${state.fullPath}'.doPrint();
      return RepositoryProvider<AuthRepo>(
        create: (context) => AuthRepo(),
        child: BlocProvider<PasswordResetBloc>(
          create: (context) => PasswordResetBloc(
            authRepo: context.read<AuthRepo>(),
          ),
          child: const PasswordResetPage(),
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

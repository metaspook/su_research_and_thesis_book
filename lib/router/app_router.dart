part of 'router.dart';

final class AppRouter {
  AppRouter({this.initialLocation, this.navigatorKey})
      : config = GoRouter(
          //-- Register routes
          routes: <RouteBase>[
            auth,
            home,
            bookmarks,
            passwordReset,
            profile,
            publisher,
            publishers,
            research,
            researchEntry,
            thesis,
            thesisEntry,
          ],
          initialLocation: initialLocation,
          navigatorKey: navigatorKey,
        ) {
    config.routeInformationProvider.value.uri.doPrint('Current Route: ');
  }

  final GlobalKey<NavigatorState>? navigatorKey;
  final String? initialLocation;
  final GoRouter config;

  //-- Define routes
  // Auth
  static final auth = GoRoute(
    name: 'auth',
    path: '/auth',
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
            ),
          ),
        ],
        child: const AuthPage(),
      );
    },
  );

  // Home
  static final home = GoRoute(
    name: 'home',
    path: '/',
    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<ResearchesNavCubit>(
            create: (context) => ResearchesNavCubit(),
          ),
          BlocProvider<ThesesNavCubit>(
            create: (context) => ThesesNavCubit(),
          ),
        ],
        child: const HomePage(),
      );
    },
  );

  // Bookmarks
  static final bookmarks = GoRoute(
    name: 'bookmarks',
    path: '/bookmarks',
    builder: (context, state) {
      return BlocProvider<BookmarksCubit>(
        create: (context) => BookmarksCubit(
          bookmarkRepo: context.read<BookmarkRepo>(),
        ),
        child: const BookmarksPage(),
      );
    },
  );

  // Password Reset
  static final passwordReset = GoRoute(
    name: 'passwordReset',
    path: '/password_reset',
    builder: (context, state) {
      return BlocProvider<PasswordResetBloc>(
        create: (context) => PasswordResetBloc(
          authRepo: context.read<AuthRepo>(),
        ),
        child: const PasswordResetPage(),
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

  // Publisher
  static final publisher = GoRoute(
    name: 'publisher',
    path: '/publisher',
    builder: (context, state) {
      final publisher = state.extra! as Publisher;
      return PublisherPage(publisher: publisher);
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

  // Research
  static final research = GoRoute(
    name: 'research',
    path: '/research',
    builder: (context, state) {
      final research = state.extra! as Research;
      return BlocProvider<ResearchCubit>(
        create: (context) => ResearchCubit(
          researchRepo: context.read<ResearchRepo>(),
          research: research,
        ),
        child: ResearchPage(research: research),
      );
    },
  );

  // Research Entry
  static final researchEntry = GoRoute(
    name: 'researchEntry',
    path: '/research_entry',
    builder: (context, state) {
      return BlocProvider<ResearchEntryCubit>(
        create: (context) => ResearchEntryCubit(
          researchRepo: context.read<ResearchRepo>(),
        ),
        child: const ResearchEntryPage(),
      );
    },
  );

  // Thesis
  static final thesis = GoRoute(
    name: 'thesis',
    path: '/thesis',
    builder: (context, state) {
      final thesis = state.extra! as Thesis;
      return BlocProvider<ThesisCubit>(
        create: (context) => ThesisCubit(
          thesisRepo: context.read<ThesisRepo>(),
          thesis: thesis,
        ),
        child: ThesisPage(thesis: thesis),
      );
    },
  );

  // Thesis Entry
  static final thesisEntry = GoRoute(
    name: 'thesisEntry',
    path: '/thesis_entry',
    builder: (context, state) {
      return BlocProvider<ThesisEntryCubit>(
        create: (context) => ThesisEntryCubit(
          thesisRepo: context.read<ThesisRepo>(),
        ),
        child: const ThesisEntryPage(),
      );
    },
  );

  // Comments
  // static final comments = GoRoute(
  //   name: 'comments',
  //   path: 'comments',
  //   builder: (context, state) {
  //     'Current Route: ${state.fullPath}'.doPrint();
  //     final thesis = state.extra! as Thesis;
  //     return RepositoryProvider<CommentRepo>(
  //       create: (context) => CommentRepo(thesisId: thesis.id),
  //       child: BlocProvider<CommentsCubit>(
  //         create: (context) => CommentsCubit(
  //           commentRepo: context.read<CommentRepo>(),
  //         ),
  //         child: CommentsPage(thesis: thesis),
  //       ),
  //     );
  //   },
  // );
}

// extension GoRouteExt on GoRoute {
//   String get pathUnderRoot => '/$path';
// }

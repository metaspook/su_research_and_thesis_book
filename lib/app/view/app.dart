import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/theme/theme.dart';

// Provide global blocs and repositories from here.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      // Provide repositories for blocs from more than one module depends on.
      // local repositories should be provided from routes.
      providers: [
        RepositoryProvider<AppUserRepo>(
          create: (context) => AppUserRepo(),
        ),
        RepositoryProvider<AuthRepo>(
          create: (context) => AuthRepo(),
        ),
        RepositoryProvider<NotificationRepo>(
          create: (context) => NotificationRepo(),
        ),
        RepositoryProvider<BookmarkRepo>(
          create: (context) => BookmarkRepo(),
        ),
        RepositoryProvider<DepartmentRepo>(
          create: (context) => DepartmentRepo(),
        ),
        RepositoryProvider<DesignationRepo>(
          create: (context) => DesignationRepo(),
        ),
        RepositoryProvider<CategoryRepo>(
          create: (context) => CategoryRepo(),
        ),
        RepositoryProvider<ResearchRepo>(
          create: (context) => ResearchRepo(),
        ),
        RepositoryProvider<ThesisRepo>(
          create: (context) => ThesisRepo(),
        ),
      ],
      child: MultiBlocProvider(
        // Provide blocs for widgets from more than one module depends on,
        // local blocs should be provided from routes.
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(
              authRepo: context.read<AuthRepo>(),
              appUserRepo: context.read<AppUserRepo>(),
            ),
          ),
          BlocProvider<NotificationsCubit>(
            create: (context) => NotificationsCubit(
              notificationRepo: context.read<NotificationRepo>(),
            ),
          ),
          BlocProvider<CategoriesCubit>(
            create: (context) => CategoriesCubit(
              categoryRepo: context.read<CategoryRepo>(),
            ),
          ),
          BlocProvider<DepartmentsCubit>(
            create: (context) => DepartmentsCubit(
              departmentRepo: context.read<DepartmentRepo>(),
            ),
          ),
          BlocProvider<DesignationsCubit>(
            create: (context) => DesignationsCubit(
              designationRepo: context.read<DesignationRepo>(),
            ),
          ),
          BlocProvider<ResearchesCubit>(
            create: (context) => ResearchesCubit(
              authRepo: context.read<AuthRepo>(),
              notificationRepo: context.read<NotificationRepo>(),
              researchRepo: context.read<ResearchRepo>(),
            ),
          ),
          BlocProvider<ThesesCubit>(
            create: (context) => ThesesCubit(
              authRepo: context.read<AuthRepo>(),
              notificationRepo: context.read<NotificationRepo>(),
              thesisRepo: context.read<ThesisRepo>(),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize global blocs those above authentication.
    context
      ..read<DepartmentsCubit>()
      ..read<DesignationsCubit>();
    final firstLaunch =
        context.select((AppCubit cubit) => cubit.state.firstLaunch);
    final isAuthenticated =
        context.select((AppCubit cubit) => cubit.state.status.isAuthenticated);
    // NOTE: This 'initialLocation' approach is experimental instead of
    // redirection from router, need see which one is performant and stable.
    final initialLocation = firstLaunch
        ? AppRouter.auth.path
        : isAuthenticated
            ? AppRouter.auth.path
            : AppRouter.auth.path;
    final router = AppRouter(initialLocation: initialLocation);

    return MaterialApp.router(
      title: 'SU Thesis Book',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router.config,
    );
  }
}

// Global bloc widgets typedef.
typedef AppBlocSelector<T> = BlocSelector<AppCubit, AppState, T>;
typedef AppBlocListener = BlocListener<AppCubit, AppState>;

typedef CategoriesBlocSelector<T>
    = BlocSelector<CategoriesCubit, CategoriesState, T>;
typedef DepartmentsBlocSelector<T>
    = BlocSelector<DepartmentsCubit, DepartmentsState, T>;
typedef DesignationsBlocSelector<T>
    = BlocSelector<DesignationsCubit, DesignationsState, T>;

typedef DepartmentsBlocListener
    = BlocListener<DepartmentsCubit, DepartmentsState>;
typedef DesignationsBlocListener
    = BlocListener<DesignationsCubit, DesignationsState>;

typedef PaperTypesBlocSelector<T>
    = BlocSelector<PaperTypesCubit, PaperTypesState, T>;
typedef ResearchesBlocSelector<T>
    = BlocSelector<ResearchesCubit, ResearchesState, T>;
typedef ThesesBlocSelector<T> = BlocSelector<ThesesCubit, ThesesState, T>;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/theme/theme.dart';

// Provide Global Blocs/Cubits and Repositories from here those don't need authentication.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(
          create: (context) => AuthRepo(),
        ),
        RepositoryProvider<AppUserRepo>(
          create: (context) => AppUserRepo(),
        ),
        RepositoryProvider<DepartmentRepo>(
          create: (context) => DepartmentRepo(),
        ),
        RepositoryProvider<DesignationRepo>(
          create: (context) => DesignationRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(
              authRepo: context.read<AuthRepo>(),
              appUserRepo: context.read<AppUserRepo>(),
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
        ],
        child: const AppView(),
      ),
    );
  }
}

typedef AppBlocSelector<T> = BlocSelector<AppCubit, AppState, T>;
typedef CategoriesBlocSelector<T>
    = BlocSelector<CategoriesCubit, CategoriesState, T>;
typedef CategoriesBlocListener = BlocListener<CategoriesCubit, CategoriesState>;
typedef DepartmentsBlocSelector<T>
    = BlocSelector<DepartmentsCubit, DepartmentsState, T>;
typedef DepartmentsBlocListener
    = BlocListener<DepartmentsCubit, DepartmentsState>;
typedef DesignationsBlocSelector<T>
    = BlocSelector<DesignationsCubit, DesignationsState, T>;
typedef DesignationsBlocListener
    = BlocListener<DesignationsCubit, DesignationsState>;
typedef ResearchesBlocSelector<T>
    = BlocSelector<ResearchesCubit, ResearchesState, T>;
typedef ResearchesBlocListener = BlocListener<ResearchesCubit, ResearchesState>;
typedef ThesesBlocSelector<T> = BlocSelector<ThesesCubit, ThesesState, T>;
typedef ThesesBlocListener = BlocListener<ThesesCubit, ThesesState>;

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTE: This approach is experimental instead of redirection from router.
    // need see which one is performant and stable.
    final isAuthenticated =
        context.select((AppCubit cubit) => cubit.state.status.isAuthenticated);
    final initialLocation =
        isAuthenticated ? AppRouter.home.path : AppRouter.auth.path;
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

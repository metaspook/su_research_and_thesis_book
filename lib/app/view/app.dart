import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/cubit/app_cubit.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/theme/theme.dart';

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
        RepositoryProvider<DesignationRepo>(
          create: (context) => DesignationRepo(),
        ),
        RepositoryProvider<DepartmentRepo>(
          create: (context) => DepartmentRepo(),
        ),
        RepositoryProvider<CategoryRepo>(
          create: (context) => CategoryRepo(),
        ),
        RepositoryProvider<ThesisRepo>(
          create: (context) => ThesisRepo(),
        ),
        RepositoryProvider<ResearchRepo>(
          create: (context) => ResearchRepo(),
        ),
      ],
      child: BlocProvider<AppCubit>(
        create: (context) => AppCubit(
          authRepo: context.read<AuthRepo>(),
          appUserRepo: context.read<AppUserRepo>(),
          designationRepo: context.read<DesignationRepo>(),
          departmentRepo: context.read<DepartmentRepo>(),
          thesisRepo: context.read<ThesisRepo>(),
          researchRepo: context.read<ResearchRepo>(),
        ),
        child: const AppView(),
      ),
    );
  }
}

typedef AppBlocSelector<T> = BlocSelector<AppCubit, AppState, T>;

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTE: This approach is experimental instead of redirection from router.
    // need see which one is performant and stable.
    final isAuthenticated =
        context.select((AppCubit cubit) => cubit.state.status.isAuthenticated);
    final initialLocation =
        isAuthenticated ? AppRouter.publisher.path : AppRouter.auth.path;
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

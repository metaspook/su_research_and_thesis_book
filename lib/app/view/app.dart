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
    final router = AppRouter();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(
          create: (context) => const AuthRepo(),
        ),
        RepositoryProvider<AppUserRepo>(
          create: (context) => const AppUserRepo(),
        ),
      ],
      child: BlocProvider<AppCubit>(
        create: (context) => AppCubit(
          authRepo: context.read<AuthRepo>(),
          appUserRepo: context.read<AppUserRepo>(),
        )..initAuth(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light(),
          darkTheme: AppThemes.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router.config,
        ),
      ),
    );
  }
}

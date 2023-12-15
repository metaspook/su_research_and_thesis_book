import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/password_reset/password_reset.dart';

typedef PasswordResetBlocSelector<T>
    = BlocSelector<PasswordResetBloc, PasswordResetState, T>;

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PasswordResetView(),
    );
  }
}

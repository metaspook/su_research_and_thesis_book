import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/thesis_entry/thesis_entry.dart';

typedef ThesisEntryBlocSelector<T>
    = BlocSelector<ThesisEntryCubit, ThesisEntryState, T>;
typedef ThesisEntryBlocListener
    = BlocListener<ThesisEntryCubit, ThesisEntryState>;

class ThesisEntryPage extends StatelessWidget {
  const ThesisEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ThesisEntryView(),
    );
  }
}

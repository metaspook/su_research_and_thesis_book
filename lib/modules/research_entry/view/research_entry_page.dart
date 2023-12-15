import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';

typedef ResearchEntryBlocSelector<T>
    = BlocSelector<ResearchEntryCubit, ResearchEntryState, T>;
typedef ResearchEntryBlocListener
    = BlocListener<ResearchEntryCubit, ResearchEntryState>;

class ResearchEntryPage extends StatelessWidget {
  const ResearchEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResearchEntryView(),
    );
  }
}

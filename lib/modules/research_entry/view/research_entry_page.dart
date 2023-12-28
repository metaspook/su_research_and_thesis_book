import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

typedef ResearchEntryBlocSelector<T>
    = BlocSelector<ResearchEntryCubit, ResearchEntryState, T>;
typedef ResearchEntryBlocListener
    = BlocListener<ResearchEntryCubit, ResearchEntryState>;

class ResearchEntryPage extends StatelessWidget {
  const ResearchEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ResearchEntryBlocListener(
          listenWhen: (previous, current) =>
              previous.statusMsg != current.statusMsg,
          listener: (context, state) {
            final snackBar = SnackBar(
              clipBehavior: Clip.none,
              content: Text(state.statusMsg!),
            );
            context.scaffoldMessenger.showSnackBar(snackBar);
          },
        ),
        ResearchEntryBlocListener(
          listenWhen: (previous, current) =>
              current.status == ResearchEntryStatus.success,
          listener: (context, state) => context.pop(),
        ),
      ],
      child: const Scaffold(
        body: ResearchEntryView(),
      ),
    );
  }
}

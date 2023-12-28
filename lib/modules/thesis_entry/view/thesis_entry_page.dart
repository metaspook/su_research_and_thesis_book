import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/thesis_entry/thesis_entry.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

typedef ThesisEntryBlocSelector<T>
    = BlocSelector<ThesisEntryCubit, ThesisEntryState, T>;
typedef ThesisEntryBlocListener
    = BlocListener<ThesisEntryCubit, ThesisEntryState>;

class ThesisEntryPage extends StatelessWidget {
  const ThesisEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        ThesisEntryBlocListener(
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
        ThesisEntryBlocListener(
          listenWhen: (previous, current) =>
              current.status == ThesisEntryStatus.success,
          listener: (context, state) => context.pop(),
        ),
      ],
      child: const Scaffold(
        body: ThesisEntryView(),
      ),
    );
  }
}

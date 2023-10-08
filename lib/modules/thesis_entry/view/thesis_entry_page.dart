import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/thesis_entry/thesis_entry.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef ThesisEntryBlocSelector<T>
    = BlocSelector<ThesisEntryCubit, ThesisEntryState, T>;
typedef ThesisEntryBlocListener
    = BlocListener<ThesisEntryCubit, ThesisEntryState>;

class ThesisEntryPage extends StatelessWidget {
  const ThesisEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<ThesisEntryCubit>();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [context.sliverAppBar(l10n.thesisEntryAppBarTitle)],
        body: ThesisEntryBlocSelector<bool>(
          selector: (state) => state.status.isLoading,
          builder: (context, isLoading) {
            return TranslucentLoader(
              enabled: isLoading,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppThemes.width * 1.5,
                  vertical: AppThemes.height * 3,
                ),
                children: [
                  // Thesis Name
                  TextFormField(
                    validator: Validator.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: cubit.onChangedThesisName,
                    decoration: InputDecoration(
                      suffixIcon: ThesisEntryBlocListener(
                        listenWhen: (previous, current) =>
                            current.status.hasMessage,
                        listener: (context, state) {
                          final snackBar = SnackBar(
                            clipBehavior: Clip.none,
                            content: Text(state.statusMsg),
                          );
                          context.scaffoldMessenger.showSnackBar(snackBar);
                        },
                        child: Builder(
                          builder: (context) {
                            final userId = context.select(
                              (AppCubit cubit) => cubit.state.user.id,
                            );
                            final enabled = context.select(
                              (ThesisEntryCubit cubit) =>
                                  cubit.state.pdfPath.isNotEmpty &&
                                  cubit.state.thesisName.isNotEmpty,
                            );
                            // Upload button
                            return TextButton.icon(
                              label: const Text('Upload'),
                              icon: const Icon(
                                Icons.upload_file_rounded,
                              ),
                              onPressed: enabled
                                  ? () => cubit.upload(userId: userId)
                                  : null,
                            );
                          },
                        ),
                      ),
                      filled: true,
                      border: AppThemes.outlineInputBorder,
                      label: const Text('Thesis Name'),
                    ),
                  ),
                  const SizedBox(height: AppThemes.height * 2),
                  // Thesis View
                  ThesisEntryBlocSelector<String>(
                    selector: (state) => state.pdfPath,
                    builder: (context, pdfPath) {
                      return Stack(
                        children: [
                          if (pdfPath.isEmpty)
                            Card(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: context.mediaQuery.size.height * .5,
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            )
                          else
                            PdfViewer(
                              pdfPath,
                              type: PdfSourceType.path,
                            ),
                          // Pick/Change PDF button
                          TextButton.icon(
                            onPressed: cubit.pick,
                            icon: const Icon(
                              Icons.file_present_rounded,
                            ),
                            label: Text(
                              pdfPath.isEmpty ? 'Pick PDF' : 'Change',
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

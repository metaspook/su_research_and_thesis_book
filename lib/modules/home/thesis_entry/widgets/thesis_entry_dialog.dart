import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

// extension ThesisEntryDialogExt on BuildContext {
//   Future<ThesisEntryDialog?> get thesisEntryDialog =>
//       showDialog<ThesisEntryDialog>(
//         context: this,
//         builder: (context) => const ThesisEntryDialog(),
//       );
// }

typedef ThesisEntryBlocSelector<T>
    = BlocSelector<ThesisEntryCubit, ThesisEntryState, T>;
typedef ThesisEntryBlocListener
    = BlocListener<ThesisEntryCubit, ThesisEntryState>;

class ThesisEntryDialog extends StatelessWidget {
  const ThesisEntryDialog({super.key});

  static Future<ThesisEntryDialog?> show(BuildContext context) =>
      showDialog<ThesisEntryDialog>(
        context: context,
        builder: (context) => const ThesisEntryDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ThesisRepo>(
      create: (context) => const ThesisRepo(),
      child: BlocProvider<ThesisEntryCubit>(
        create: (context) =>
            ThesisEntryCubit(thesisRepo: context.read<ThesisRepo>()),
        child: Builder(
          builder: (context) {
            final cubit = context.read<ThesisEntryCubit>();
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: const Text('Thesis Entry', textAlign: TextAlign.center),
              content: SizedBox(
                width: context.mediaQuery.size.width,
                child: Stack(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 80),
                        ThesisEntryBlocSelector<String>(
                          selector: (state) => state.pdfPath,
                          builder: (context, pdfPath) {
                            return Stack(
                              children: [
                                if (pdfPath.isEmpty)
                                  Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      height:
                                          context.mediaQuery.size.height * .5,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton.icon(
                                            onPressed: cubit.pickPdf,
                                            icon: const Icon(
                                              Icons.upload_file_rounded,
                                            ),
                                            label: const Text('Upload'),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                else
                                  PdfViewer(
                                    // 'https://css4.pub/2015/usenix/example.pdf'
                                    uri: pdfPath,
                                    source: PdfSource.path,
                                    heightPercent: .5,
                                  ),
                                TextButton.icon(
                                  onPressed: cubit.pickPdf,
                                  icon: const Icon(
                                    Icons.upload_file_rounded,
                                  ),
                                  label: const Text('Upload'),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    TextField(
                      onChanged: cubit.onChangedThesisName,
                      decoration: const InputDecoration(
                        filled: true,
                        border: AppThemes.outlineInputBorder,
                        label: Text('Thesis Name'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

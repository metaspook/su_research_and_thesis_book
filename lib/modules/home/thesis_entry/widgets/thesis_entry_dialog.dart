import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/router/app_router.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

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
      create: (context) => ThesisRepo(),
      child: BlocProvider<ThesisEntryCubit>(
        create: (context) =>
            ThesisEntryCubit(thesisRepo: context.read<ThesisRepo>()),
        child: Builder(
          builder: (context) {
            final cubit = context.read<ThesisEntryCubit>();
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: const Text('Thesis Entry', textAlign: TextAlign.center),
              content: ClipRRect(
                borderRadius: AppThemes.borderRadius,
                child: Container(
                  width: context.mediaQuery.size.width,
                  padding: const EdgeInsets.only(top: 3.5),
                  child: ThesisEntryBlocSelector<bool>(
                    selector: (state) => state.status.isLoading,
                    builder: (context, isLoading) {
                      return TranslucentLoader(
                        enabled: isLoading,
                        child: Stack(
                          children: [
                            // Thesis View
                            ListView(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                const SizedBox(height: AppThemes.height6x),
                                ThesisEntryBlocSelector<String>(
                                  selector: (state) => state.pdfPath,
                                  builder: (context, pdfPath) {
                                    return Stack(
                                      children: [
                                        if (pdfPath.isEmpty)
                                          Card(
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              height: context
                                                      .mediaQuery.size.height *
                                                  .5,
                                              child: const Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                            pdfPath.isEmpty
                                                ? 'Pick PDF'
                                                : 'Change',
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                            // Thesis Name
                            TextFormField(
                              validator: Validator.name,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: cubit.onChangedThesisName,
                              decoration: InputDecoration(
                                suffixIcon: ThesisEntryBlocListener(
                                  listenWhen: (previous, current) =>
                                      current.status.hasMessage,
                                  listener: (context, state) {
                                    context.pop();
                                    final snackBar = SnackBar(
                                      clipBehavior: Clip.none,
                                      content: Text(state.statusMsg),
                                    );
                                    context.scaffoldMessenger
                                        .showSnackBar(snackBar);
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
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

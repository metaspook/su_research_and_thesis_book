import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

// extension ResearchEntryDialogExt on BuildContext {
//   Future<ResearchEntryDialog?> get researchEntryDialog =>
//       showDialog<ResearchEntryDialog>(
//         context: this,
//         builder: (context) => const ResearchEntryDialog(),
//       );
// }

class ResearchEntryDialog extends StatelessWidget {
  const ResearchEntryDialog({super.key});

  static Future<ResearchEntryDialog?> show(BuildContext context) =>
      showDialog<ResearchEntryDialog>(
        context: context,
        builder: (context) => const ResearchEntryDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ResearchRepo>(
      create: (context) => ResearchRepo(),
      child: BlocProvider<ResearchEntryCubit>(
        create: (context) =>
            ResearchEntryCubit(researchRepo: context.read<ResearchRepo>()),
        child: Builder(
          builder: (context) {
            final cubit = context.read<ResearchEntryCubit>();
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: const Text('Research Entry', textAlign: TextAlign.center),
              content: ClipRRect(
                borderRadius: AppThemes.borderRadius,
                child: Container(
                  width: context.mediaQuery.size.width,
                  padding: const EdgeInsets.only(top: 3.5),
                  child: ResearchEntryBlocSelector<bool>(
                    selector: (state) => state.status.isLoading,
                    builder: (context, isLoading) {
                      return TranslucentLoader(
                        enabled: isLoading,
                        child: Stack(
                          children: [
                            // Research View
                            ListView(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                const SizedBox(height: AppThemes.height * 6),
                                ResearchEntryBlocSelector<String>(
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
                            // Research Name
                            TextFormField(
                              validator: Validator.name,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: cubit.onChangedResearchName,
                              decoration: InputDecoration(
                                suffixIcon: ResearchEntryBlocListener(
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
                                        (ResearchEntryCubit cubit) =>
                                            cubit.state.pdfPath.isNotEmpty &&
                                            cubit.state.researchName.isNotEmpty,
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
                                label: const Text('Research Name'),
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

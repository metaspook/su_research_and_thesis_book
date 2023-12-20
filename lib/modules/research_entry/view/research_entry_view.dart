import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ResearchEntryView extends StatelessWidget {
  const ResearchEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories =
        context.select((CategoriesCubit cubit) => cubit.state.categories);
    final l10n = context.l10n;
    final cubit = context.read<ResearchEntryCubit>();

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) =>
          [context.sliverAppBar(l10n.researchEntryAppBarTitle)],
      body: ResearchEntryBlocSelector<bool>(
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
                // Research Title
                TextFormField(
                  validator: Validator.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: cubit.onChangedTitle,
                  decoration: const InputDecoration(
                    filled: true,
                    border: AppThemes.outlineInputBorder,
                    label: Text('Title'),
                  ),
                ),
                const SizedBox(height: AppThemes.height * 2),
                // Research Category
                DropdownButtonFormField<int>(
                  menuMaxHeight: AppThemes.menuMaxHeight,
                  dropdownColor:
                      context.theme.colorScheme.background.withOpacity(.75),
                  decoration: const InputDecoration(
                    label: Text('Category'),
                    filled: true,
                    border: AppThemes.outlineInputBorder,
                  ),
                  borderRadius: AppThemes.borderRadius,
                  onChanged: cubit.onChangedCategory,
                  items: categories
                      ?.map<DropdownMenuItem<int>>(
                        (category) => DropdownMenuItem<int>(
                          value: categories.indexOf(category),
                          child: Text(category),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: AppThemes.height * 2),
                // Research Description
                TextField(
                  maxLength: 150,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    filled: true,
                    border: AppThemes.outlineInputBorder,
                  ),
                  onChanged: cubit.onChangedDescription,
                ),
                const SizedBox(height: AppThemes.height * 1.5),
                // Research Preview
                ResearchEntryBlocSelector<String>(
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
                const SizedBox(height: AppThemes.height * 2),
                // Upload button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ResearchEntryBlocListener(
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
                          (ResearchEntryCubit cubit) =>
                              cubit.state.pdfPath.isNotEmpty &&
                              cubit.state.title.isNotEmpty,
                        );
                        return ElevatedButton.icon(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

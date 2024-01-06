import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/research_entry/research_entry.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef ResearchNewEntryBlocSelector<T>
    = BlocSelector<ResearchNewEntryCubit, ResearchNewEntryState, T>;
typedef ResearchNewEntryBlocListener
    = BlocListener<ResearchNewEntryCubit, ResearchNewEntryState>;

class ResearchNewEntryView extends StatelessWidget {
  const ResearchNewEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories =
        context.select((CategoriesCubit cubit) => cubit.state.categories);
    final isLoading = context
        .select((ResearchNewEntryCubit cubit) => cubit.state.status.isLoading);
    final cubit = context.read<ResearchNewEntryCubit>();

    return ResearchNewEntryBlocListener(
      listenWhen: (previous, current) =>
          previous.statusMsg != current.statusMsg,
      listener: (context, state) => context.showAppSnackBar(state.statusMsg),
      child: TranslucentLoader(
        enabled: isLoading || categories == null,
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
              isExpanded: true,
              menuMaxHeight: AppThemes.menuMaxHeight,
              dropdownColor:
                  context.theme.colorScheme.background.withOpacity(.75),
              decoration: const InputDecoration(
                label: Text('Category'),
                filled: true,
                border: AppThemes.outlineInputBorder,
              ),
              borderRadius: AppThemes.borderRadius,
              onChanged: cubit.onChangedDepartment,
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
            ResearchNewEntryBlocSelector<String>(
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
              child: Builder(
                builder: (context) {
                  final userId = context.select(
                    (AppCubit cubit) => cubit.state.user.id,
                  );
                  final enabled = context.select(
                    (ResearchNewEntryCubit cubit) =>
                        cubit.state.pdfPath.isNotEmpty &&
                        cubit.state.title.isNotEmpty,
                  );
                  return ElevatedButton.icon(
                    label: const Text('Upload'),
                    icon: const Icon(
                      Icons.upload_file_rounded,
                    ),
                    onPressed:
                        enabled ? () => cubit.upload(userId: userId) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

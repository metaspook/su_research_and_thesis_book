import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/modules/thesis/cubit/thesis_cubit.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/utils/extensions.dart';

typedef ThesisBlocListener = BlocListener<ThesisCubit, ThesisState>;

class ThesisPage extends StatelessWidget {
  const ThesisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThesisCubit>();
    final thesis = context.select((ThesisCubit cubit) => cubit.state.thesis);

    return ThesisBlocListener(
      listenWhen: (previous, current) =>
          previous.statusMsg != current.statusMsg,
      listener: (context, state) => context.showAppSnackBar(state.statusMsg),
      child: thesis == null
          ? Scaffold(
              appBar: AppBar(
                leading: context.backButton(),
                title: const Text('Thesis Page'),
                centerTitle: true,
              ),
              body: Center(child: context.emptyListText()),
            )
          : Scaffold(
              appBar: AppBar(
                leading: context.backButton(),
                centerTitle: true,
                title: Text(thesis.title.toStringParseNull()),
                actions: [
                  // Bookmark button
                  IconButton(
                    padding: EdgeInsets.zero,
                    // alignment: Alignment.center,
                    onPressed: cubit.onPressedBookmark,
                    icon: const Icon(Icons.bookmark_add_rounded),
                  ),
                  // Download button
                  IconButton(
                    padding: const EdgeInsets.only(top: kToolbarHeight * 0.04),
                    // alignment: Alignment.center,
                    onPressed: cubit.onPressedDownload,
                    icon: const Icon(Icons.download_rounded),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      clipBehavior: Clip.none,
                      child: Column(
                        children: [
                          PdfViewer(
                            thesis.fileUrl!,
                            whenDone: cubit.whenDoneLoading,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CounterBadge(
                                label: 'Views',
                                count: thesis.views,
                                largeSize: 27.5,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 6,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () => Future.wait([
                                  cubit.incrementViews(
                                    thesis,
                                    firstView: false,
                                  ),
                                  context.pushNamed(
                                    AppRouter.comments.name!,
                                    extra: Paper(
                                      type: PaperType.thesis,
                                      id: thesis.id,
                                      title: thesis.title,
                                    ),
                                  ),
                                ]),
                                icon: const Icon(Icons.comment_outlined),
                                label: const Text('Comments'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

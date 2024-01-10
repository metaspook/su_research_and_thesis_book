import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/modules/research/research.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

typedef ResearchBlocListener = BlocListener<ResearchCubit, ResearchState>;

class ResearchPage extends StatelessWidget {
  const ResearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResearchCubit>();
    final research =
        context.select((ResearchCubit cubit) => cubit.state.research);

    return ResearchBlocListener(
      listenWhen: (previous, current) =>
          previous.statusMsg != current.statusMsg,
      listener: (context, state) => context.showAppSnackBar(state.statusMsg),
      child: research == null
          ? Scaffold(
              appBar: AppBar(title: const Text('Thesis Page')),
              body: context.emptyListText(),
            )
          : Scaffold(
              appBar: AppBar(
                leading: context.backButton(),
                centerTitle: true,
                title: Text(research.title.toStringParseNull()),
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
                    padding: EdgeInsets.zero,
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
                            research.fileUrl!,
                            whenDone: cubit.whenDoneLoading,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CounterBadge(
                                label: 'Views',
                                count: research.views,
                                largeSize: 27.5,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 6,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () => Future.wait([
                                  cubit.incrementViews(
                                    research,
                                    firstView: false,
                                  ),
                                  context.pushNamed(
                                    AppRouter.comments.name!,
                                    extra: (
                                      type: PaperType.research,
                                      id: research.id
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/research/research.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/extensions.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef ResearchBlocListener = BlocListener<ResearchCubit, ResearchState>;

class ResearchPage extends StatelessWidget {
  const ResearchPage({required this.research, super.key});

  final Research research;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResearchCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: context.backButton(),
        centerTitle: true,
        title: Text(research.title.toStringParseNull()),
        actions: [
          ResearchBlocListener(
            listenWhen: (previous, current) => current.status.hasMessage,
            listener: (context, state) {
              final snackBar = SnackBar(
                backgroundColor: context.theme.snackBarTheme.backgroundColor
                    ?.withOpacity(.25),
                behavior: SnackBarBehavior.floating,
                content: Text(state.statusMsg),
              );
              context.scaffoldMessenger.showSnackBar(snackBar);
            },
            child: IconButton(
              padding: EdgeInsets.zero,
              // alignment: Alignment.center,
              onPressed: cubit.onPressedDownload,
              icon: const Icon(Icons.download_rounded),
            ),
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
                  PdfViewer(research.fileUrl!, whenDone: cubit.whenDoneLoading),
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
                          cubit.incrementViews(research, firstView: false),
                          // context.pushNamed(
                          //   AppRouter.comments.name!,
                          //   extra: research,
                          // ),
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
    );
  }
}

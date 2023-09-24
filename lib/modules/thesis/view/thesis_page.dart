import 'package:flutter/material.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class ThesisPage extends StatelessWidget {
  const ThesisPage({required this.thesis, super.key});

  final Thesis thesis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.backButton(),
        centerTitle: true,
        title: Text(thesis.name ?? 'N/A'),
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
                  PdfViewer(thesis.fileUrl!),
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
                        onPressed: () => context
                            .pushNamed(AppRouter.comments.name!, extra: thesis),
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

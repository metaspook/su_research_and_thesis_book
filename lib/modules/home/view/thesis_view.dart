import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/comments/comments.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

class ThesisView extends StatelessWidget {
  const ThesisView({required this.thesis, super.key});

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
          // mainAxisSize: MainAxisSize.min,
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
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute<CommentsPage>(
                            builder: (context) => const CommentsPage(),
                          ),
                        ),
                        icon: const Icon(Icons.comment_outlined),
                        label: const Text('Comments'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // const Card(
            //   elevation: 4,
            //   child: Padding(
            //     padding: EdgeInsets.all(12),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Text('Views'),
            //         Text('Comments'),
            //         Text('Comments'),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

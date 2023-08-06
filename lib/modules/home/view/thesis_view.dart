import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/shared.dart';
import 'package:su_thesis_book/utils/extensions.dart';

class ThesisView extends StatefulWidget {
  const ThesisView({required this.thesis, super.key});

  final Thesis thesis;

  @override
  State<ThesisView> createState() => _ThesisViewState();
}

class _ThesisViewState extends State<ThesisView> {
  late PDFViewController pdfViewController;

  int pageCount = 0;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final text = '${pageIndex + 1} / $pageCount';
    return Scaffold(
      appBar: AppBar(
        leading: Mod.backButton(context),
        centerTitle: true,
        title: Text(widget.thesis.name),
        actions: const [
          // IconButton(
          //   visualDensity: VisualDensity.compact,
          //   onPressed: () {
          //     final page = pageIndex == 0 ? pageCount : pageIndex - 1;
          //     pdfViewController.setPage(page);
          //   },
          //   icon: const Icon(Icons.chevron_left_rounded),
          // ),
          // Text(text),
          // IconButton(
          //   visualDensity: VisualDensity.compact,
          //   onPressed: () {
          //     final page = pageIndex == pageCount - 1 ? 0 : pageIndex + 1;
          //     pdfViewController.setPage(page);
          //   },
          //   icon: const Icon(Icons.chevron_right_rounded),
          // )
        ],
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
                  LimitedBox(
                    maxHeight: context.mediaQuery.size.height * .8225,
                    child: Stack(
                      children: [
                        PDF(
                          swipeHorizontal: true,
                          // autoSpacing: false,
                          // pageFling: false,
                          fitEachPage: false,
                          // onError: print,
                          onRender: (pages) => setState(() {
                            pageCount = pages!;
                          }),
                          onViewCreated: (controller) =>
                              setState(() => pdfViewController = controller),
                          onPageChanged: (page, total) => setState(() {
                            pageIndex = page!;
                          }),
                          // onPageError: (page, error) {
                          //   print('$page: $error');
                          // },
                          // onPageChanged: (page, total) {
                          //   print('page change: $page/$total');
                          // },
                        ).cachedFromUrl(
                          'https://css4.pub/2015/usenix/example.pdf',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                final page =
                                    pageIndex == 0 ? pageCount : pageIndex - 1;
                                pdfViewController.setPage(page);
                              },
                              icon: const Icon(Icons.chevron_left_rounded),
                            ),
                            Text(
                              text,
                              style: context
                                  .theme.textButtonTheme.style?.textStyle
                                  ?.resolve({
                                MaterialState.pressed,
                                MaterialState.hovered,
                                MaterialState.focused,
                              }),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                final page = pageIndex == pageCount - 1
                                    ? 0
                                    : pageIndex + 1;
                                pdfViewController.setPage(page);
                              },
                              icon: const Icon(Icons.chevron_right_rounded),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Row(
                        children: [
                          // Icon(Icons.remove_red_eye_rounded),
                          // Text(' Views: 10'),
                          Column(
                            children: [
                              CounterBadge(
                                label: 'Views',
                                count: 20,
                                largeSize: 27.5,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 6,
                                ),
                              ),
                              // CounterBadge(label: 'Comments', count: 10),
                            ],
                          ),
                        ],
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

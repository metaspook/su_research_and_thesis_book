import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:su_thesis_book/shared/shared.dart';

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
        title: Text(widget.thesis.name),
        actions: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              final page = pageIndex == 0 ? pageCount : pageIndex - 1;
              pdfViewController.setPage(page);
            },
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Text(text),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              final page = pageIndex == pageCount - 1 ? 0 : pageIndex + 1;
              pdfViewController.setPage(page);
            },
            icon: const Icon(Icons.chevron_right_rounded),
          )
        ],
      ),
      body: PDF(
        // swipeHorizontal: true,
        // autoSpacing: false,
        // pageFling: false,
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
      ).cachedFromUrl('http://africau.edu/images/default/sample.pdf'),
    );
  }
}

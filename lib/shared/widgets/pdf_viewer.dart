import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:su_thesis_book/theme/theme.dart';

enum PdfSource { asset, url, path }

class PdfViewer extends StatefulWidget {
  /// `heightPercent` (which ranges from 0.0 to 1.0) is percentage of
  /// `MediaQuery.of(context).size.height`.
  ///
  /// Out of range values will have unexpected effects.
  const PdfViewer({
    required this.uri,
    this.source = PdfSource.url,
    this.heightPercent = .8225,
    super.key,
  });

  final String uri;
  final PdfSource source;
  final double heightPercent;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late PDFViewController pdfViewController;

  int pageCount = 0;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final text = '${pageIndex + 1} / $pageCount';
    final pdf = PDF(
      swipeHorizontal: true,
      onRender: (pages) => setState(() {
        pageCount = pages!;
      }),
      onViewCreated: (controller) =>
          setState(() => pdfViewController = controller),
      onPageChanged: (page, total) => setState(() {
        pageIndex = page!;
      }),
      // onLinkHandler: (uri) => print('Clicked Link : $uri'),
    );

    return LimitedBox(
      maxHeight: context.mediaQuery.size.height * widget.heightPercent,
      child: Stack(
        children: [
          switch (widget.source) {
            PdfSource.asset => pdf.fromAsset(widget.uri),
            PdfSource.path => pdf.fromPath(widget.uri),
            PdfSource.url => pdf.cachedFromUrl(widget.uri),
          },
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  final page = pageIndex == 0 ? pageCount : pageIndex - 1;
                  pdfViewController.setPage(page);
                },
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              Text(
                text,
                style: context.theme.textButtonTheme.style?.textStyle?.resolve({
                  MaterialState.pressed,
                  MaterialState.hovered,
                  MaterialState.focused,
                }),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  final page = pageIndex == pageCount - 1 ? 0 : pageIndex + 1;
                  pdfViewController.setPage(page);
                },
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

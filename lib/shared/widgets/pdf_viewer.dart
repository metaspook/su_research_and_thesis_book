import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:su_thesis_book/theme/theme.dart';

enum PdfSourceType { asset, url, path }

class PdfViewer extends StatefulWidget {
  /// `heightPercent` (which ranges from 0.0 to 1.0) is percentage of
  /// `MediaQuery.of(context).size.height`.
  ///
  /// Out of range values will have unexpected effects.
  const PdfViewer(this.source, {this.type = PdfSourceType.url, super.key});

  final String source;
  final PdfSourceType type;
  // final double heightPercent;
  // this.heightPercent = .8225,
  // 'https://css4.pub/2015/usenix/example.pdf'

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

    return SizedBox(
      height: context.mediaQuery.size.height * .7925,
      // width: context.mediaQuery.size.width,
      child: Stack(
        children: [
          switch (widget.type) {
            PdfSourceType.asset => pdf.fromAsset(widget.source),
            PdfSourceType.path => pdf.fromPath(widget.source),
            PdfSourceType.url => pdf.cachedFromUrl(widget.source),
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

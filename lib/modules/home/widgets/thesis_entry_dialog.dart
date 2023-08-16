import 'package:flutter/material.dart';
import 'package:su_thesis_book/theme/theme.dart';

// extension ThesisEntryDialogExt on BuildContext {
//   Future<ThesisEntryDialog?> get thesisEntryDialog =>
//       showDialog<ThesisEntryDialog>(
//         context: this,
//         builder: (context) => const ThesisEntryDialog(),
//       );
// }

class ThesisEntryDialog extends StatelessWidget {
  const ThesisEntryDialog({super.key});

  static Future<ThesisEntryDialog?> show(BuildContext context) =>
      showDialog<ThesisEntryDialog>(
        context: context,
        builder: (context) => const ThesisEntryDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: const Text('Thesis Entry', textAlign: TextAlign.center),
      content: SizedBox(
        width: context.mediaQuery.size.width,
        child: Stack(
          // mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 80),
                Card(
                  // color: Colors.cyan,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: context.mediaQuery.size.height * .5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.upload_file_rounded),
                          label: const Text('Upload'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // const PdfViewer(
            //   uri: 'https://css4.pub/2015/usenix/example.pdf',
            //   heightPercent: .5,
            // ),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                border: AppThemes.outlineInputBorder,
                label: Text('Thesis Name'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

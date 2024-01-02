import 'package:flutter/material.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/theme/theme.dart';

extension NotAllowedDialogExt on BuildContext {
  /// {@macro show}
  Future<T?> showNotAllowedDialog<T extends Object?>() =>
      NotAllowedDialog.show<T>(this);
}

/// Full screen notAllowed dialog.
class NotAllowedDialog extends StatelessWidget {
  const NotAllowedDialog({super.key});

  /// {@template show}
  /// Method to show notAllowed dialog.
  /// {@endtemplate}
  static Future<T?> show<T extends Object?>(BuildContext context) =>
      showDialog<T>(
        context: context,
        builder: (context) => const NotAllowedDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(10),
      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Not available for student!',
                style: context.theme.textTheme.labelLarge?.copyWith(
                  fontSize: context.mediaQuery.size.width * .06,
                ),
              ),
            ),
            IconButton(
              onPressed: context.pop,
              icon: const Icon(
                Icons.close_rounded,
                size: kToolbarHeight * .575,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: context.pop,
                child: const Text('Understand'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

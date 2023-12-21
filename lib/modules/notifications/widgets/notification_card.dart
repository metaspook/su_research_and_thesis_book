import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/extensions.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      // this.thesis,
      {
    // this.selected = false,
    // this.onTap,
    // this.onLongPress,
    super.key,
  });

  // final Thesis thesis;
  // final bool selected;
  // final VoidCallback? onTap;
  // final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final dateStr = thesis.createdAt == null
    //     ? 'N/A'
    //     : DateFormat('EEE, y/M/d').format(thesis.createdAt!);
    final isChemistry = Random().nextBool();
    final rating = (Random().nextDouble() * 5).toStringAsFixed(1).toDouble();
    final classNumber = Random().nextInt(12) + 1;
    final groupName = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[Random().nextInt(26)];
    final studentCount = Random().nextInt(101).toString().padLeft(2, '0');
    DateFormat.HOUR_MINUTE.doPrint();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Random().nextBool()
                  ? 'New Student enrolled!'
                  : 'Live class scheduled!',
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(Icons.swap_horizontal_circle_outlined),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final e in ['y-M-d', 'h:mm a'])
              Text(
                DateFormat(e).format(DateTime.now()),
                style: TextStyle(
                  color: context.theme.badgeTheme.backgroundColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

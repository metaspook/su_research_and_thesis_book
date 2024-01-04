import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
    this.notification, {
// this.selected = false,
    // this.onTap,
    // this.onLongPress,
    super.key,
  });

  final AppNotification notification;
  // final bool selected;
  // final VoidCallback? onTap;
  // final VoidCallback? onLongPress;
  // final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // final text2 = record.type == NotificationType.research
    // final theme = Theme.of(context);
    // final dateStr = thesis.createdAt == null
    //     ? 'N/A'
    //     : DateFormat('EEE, y/M/d').format(thesis.createdAt!);
    // final isChemistry = Random().nextBool();
    // final rating = (Random().nextDouble() * 5).toStringAsFixed(1).toDouble();
    // final classNumber = Random().nextInt(12) + 1;
    // final groupName = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[Random().nextInt(26)];
    // final studentCount = Random().nextInt(101).toString().padLeft(2, '0');
    // DateFormat.HOUR_MINUTE.doPrint();

    // final ss = Text.rich(
    //   TextSpan(
    //     text: 'A ',
    //     children: [
    //       TextSpan(
    //         text: publisher.designation.toStringParseNull(),
    //         style: const TextStyle(fontWeight: FontWeight.bold),
    //       ),
    //     ],
    //   ),
    //   overflow: TextOverflow.ellipsis,
    //   style: context.theme.textTheme.titleSmall?.copyWith(
    //     color: context.theme.badgeTheme.backgroundColor,
    //   ),
    // );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () => context.pushNamed(notification.type.name,
            extra: notification.paperId),
        dense: true,
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.userName.toStringParseNull(),
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.labelLarge?.copyWith(
                    color: context.theme.textTheme.labelLarge?.color
                        ?.withOpacity(.5),
                  ),
                ),
                Text(
                  notification.type.data,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.labelLarge,
                ),
                Text(
                  notification.paperName.toStringParseNull(),
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.labelLarge?.copyWith(
                    color: context.theme.textTheme.labelLarge?.color
                        ?.withOpacity(.5),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.swap_horizontal_circle_outlined),
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              padding: EdgeInsets.zero,
              iconSize: kToolbarHeight * .5,
              onPressed: () {},
            ),
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

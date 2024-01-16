import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(this.notification, {super.key});
  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () {
          context.read<NotificationsCubit>().onDecrementUnseenCount();
          if (notification.type == NotificationType.comments) {
            context.pushNamed(
              notification.paper.type.name,
              extra: notification.paper,
            );
          }
          context.pushNamed(
            notification.type.name,
            extra: notification.paper,
          );
        },
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
                  notification.paper.title.toStringParseNull(),
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.labelLarge?.copyWith(
                    color: context.theme.textTheme.labelLarge?.color
                        ?.withOpacity(.5),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.swap_horizontal_circle_outlined,
              size: kToolbarHeight * .5,
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

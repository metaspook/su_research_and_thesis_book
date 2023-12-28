import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/notifications/notifications.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef NotificationsBlocSelector<T>
    = BlocSelector<NotificationsCubit, NotificationsState, T>;

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const NotificationsAppBar(),
        ],
        body: NotificationsBlocSelector<List<NotificationRecord>>(
          selector: (state) => state.notificationRecords,
          builder: (context, notificationRecords) {
            return notificationRecords.isEmpty
                ? context.emptyListText()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: AppThemes.viewPadding,
                    itemCount: notificationRecords.length,
                    itemBuilder: (context, index) {
                      final record = notificationRecords[index];
                      return Dismissible(
                        key: Key(index.toString()),
                        child: NotificationCard(record),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

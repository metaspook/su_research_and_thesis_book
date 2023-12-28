import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/notifications/notifications.dart';
import 'package:su_thesis_book/theme/theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const NotificationsAppBar(),
        ],
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: AppThemes.viewPadding,
          itemCount: 10,
          itemBuilder: (context, index) {
            final record = (type: );
            return Dismissible(
              key: Key(index.toString()),
              child: const NotificationCard(),
            );
          },
        ),
      ),
    );
  }
}

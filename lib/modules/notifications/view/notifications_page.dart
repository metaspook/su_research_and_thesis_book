import 'package:flutter/material.dart';
import 'package:su_thesis_book/l10n/l10n.dart';
import 'package:su_thesis_book/modules/notifications/notifications.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          context.sliverAppBar(
            context.l10n.notificationsAppBarTitle,
            bottom: ClipRRect(
              borderRadius: AppThemes.bottomRadius,
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: context.theme.colorScheme.primaryContainer,
                child: Text(
                  '💡 Swipe cards left or right to dismiss 💡',
                  style: context.theme.textTheme.labelSmall,
                ),
              ),
            ).toPreferredSize(const Size.fromHeight(kToolbarHeight * .30)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: AppThemes.width * .6),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    size: kToolbarHeight * .575,
                  ),
                  onPressed: () {
                    showDialog<AlertDialog>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.all(10),
                          title: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Dismiss all notifications?',
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
                                    onPressed: () => context.pop(),
                                    child: const Text('Proceed'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: AppThemes.viewPadding,
          itemCount: 10,
          itemBuilder: (context, index) => Dismissible(
            key: Key(index.toString()),
            child: const NotificationCard(),
          ),
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //   label: const Text('Add Thesis'),
      //   icon: const Icon(Icons.playlist_add_outlined),
      //   onPressed: () => ThesisEntryDialog.show(context),
      // ),
    );
  }
}

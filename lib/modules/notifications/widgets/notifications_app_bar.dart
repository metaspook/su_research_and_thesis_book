import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_research_and_thesis_book/app/app.dart';
import 'package:su_research_and_thesis_book/l10n/l10n.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationsCubit>();

    return context.sliverAppBar(
      context.l10n.notificationsAppBarTitle,
      centerTitle: false,
      bottom: ClipRRect(
        borderRadius: AppThemes.bottomRadius,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: context.theme.colorScheme.primaryContainer,
          child: Text(
            '💡 Swipe left or right to dismiss | Tap to view 💡',
            style: context.theme.textTheme.labelSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ).toPreferredSize(const Size.fromHeight(kToolbarHeight * .5)),
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
                          Text(
                            'Dismiss all notifications?',
                            style: context.theme.textTheme.titleLarge,
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
                              onPressed: () {
                                cubit.onAllDismissed();
                                context.pop();
                              },
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
    );
  }
}

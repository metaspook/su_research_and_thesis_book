import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/router/app_router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/theme/extensions.dart';

class ThesisCard extends StatelessWidget {
  const ThesisCard(this.thesis, {super.key});

  final Thesis thesis;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final theme = Theme.of(context);
    final dateStr = thesis.createdAt == null
        ? 'N/A'
        : DateFormat('EEE, y/M/d').format(thesis.createdAt!);

    return Card(
      child: ListTile(
        onTap: () => Future.wait([
          context.push(AppRouter.thesis.pathUnderRoot, extra: thesis),
          cubit.incrementViews(thesis),
        ]),
        title: Text(
          thesis.name ?? 'N/A',
          style: context.theme.textTheme.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Author: ',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: theme.badgeTheme.backgroundColor,
                ),
                children: [
                  TextSpan(
                    text: thesis.author ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Posted: ',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: theme.badgeTheme.backgroundColor,
                ),
                children: [
                  TextSpan(
                    text: dateStr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CounterBadge(label: 'Views', count: thesis.views, largeSize: 20),
            CounterBadge(
              label: 'Comments',
              count: thesis.comments.length,
              largeSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}

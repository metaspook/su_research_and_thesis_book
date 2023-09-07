import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:su_thesis_book/modules/home/home.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/theme/extensions.dart';

class ThesisCard extends StatelessWidget {
  const ThesisCard(this.thesis, {super.key});

  final Thesis thesis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('EEE, y/M/d').format(thesis.createdAt);

    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<ThesisView>(
            builder: (context) => ThesisView(thesis: thesis),
          ),
        ),
        title: Text(
          thesis.name,
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
                    text: thesis.author,
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
        trailing: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CounterBadge(label: 'Views', count: 20, largeSize: 20),
            CounterBadge(label: 'Comments', count: 10, largeSize: 20),
          ],
        ),
      ),
    );
  }
}

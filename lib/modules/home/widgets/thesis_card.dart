import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/extensions.dart';

class ThesisCard extends StatelessWidget {
  const ThesisCard(
    this.thesis, {
    this.selected = false,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  final Thesis thesis;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = thesis.createdAt == null
        ? 'N/A'
        : DateFormat('EEE, y/M/d').format(thesis.createdAt!);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        selected: selected,
        // shape: selected ? AppThemes.outlineInputBorder : null,
        onLongPress: onLongPress,
        onTap: onTap ??
            () => context.push(AppRouter.thesis.pathUnderRoot, extra: thesis),
        leading: HaloAvatar(thesis.authorPhotoUrl),
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
          children: [
            CounterBadge(label: 'Views', count: thesis.views, largeSize: 20),
          ],
        ),
      ),
    );
  }
}

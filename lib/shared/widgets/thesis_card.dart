import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/extensions.dart';
import 'package:su_research_and_thesis_book/utils/extensions.dart';

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
    final dateStr = thesis.createdAt == null
        ? 'N/A'
        : DateFormat('EEE, y/M/d').format(thesis.createdAt!);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        dense: true,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
        ),
        selected: selected,
        // shape: selected ? AppThemes.outlineInputBorder : null,
        onLongPress: onLongPress,
        onTap: onTap ??
            () =>
                context.pushNamed(AppRouter.thesis.name!, extra: thesis.paper),
        // onTap: onTap ??
        //     () => context.push(AppRouter.thesis.pathUnderRoot, extra: thesis),
        leading: HaloAvatar(url: thesis.publisher?.photoUrl),
        title: Text(
          thesis.title.toStringParseNull(),
          overflow: TextOverflow.ellipsis,
          style: context.theme.textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Author: ',
                children: [
                  TextSpan(
                    text: thesis.publisher?.name.toStringParseNull(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.theme.badgeTheme.backgroundColor,
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Posted: ',
                children: [
                  TextSpan(
                    text: dateStr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.theme.badgeTheme.backgroundColor,
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

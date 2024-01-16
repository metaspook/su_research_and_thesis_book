import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:su_research_and_thesis_book/router/router.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';
import 'package:su_research_and_thesis_book/shared/widgets/widgets.dart';
import 'package:su_research_and_thesis_book/theme/extensions.dart';
import 'package:su_research_and_thesis_book/utils/extensions.dart';

class ResearchCard extends StatelessWidget {
  const ResearchCard(
    this.research, {
    this.selected = false,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  final Research research;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final dateStr = research.createdAt == null
        ? 'N/A'
        : DateFormat('EEE, y/M/d').format(research.createdAt!);

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
            () => context.pushNamed(
                  AppRouter.research.name!,
                  extra: research.paper,
                ),
        // onTap: onTap ??
        //     () =>
        //         context.push(AppRouter.research.pathUnderRoot, extra: research),
        leading: HaloAvatar(url: research.publisher?.photoUrl),
        title: Text(
          research.title.toStringParseNull(),
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
                    text: research.publisher?.name.toStringParseNull(),
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
            CounterBadge(label: 'Views', count: research.views, largeSize: 20),
          ],
        ),
      ),
    );
  }
}

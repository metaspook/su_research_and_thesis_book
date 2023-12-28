import 'package:flutter/material.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/extensions.dart';
import 'package:su_thesis_book/utils/utils.dart';

class PublisherCard extends StatelessWidget {
  const PublisherCard(
    this.publisher, {
    this.selected = false,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  final Publisher publisher;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
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
        onTap: () =>
            context.pushNamed(AppRouter.publisher.name!, extra: publisher),
        // onTap: onTap ??
        //     () => context.push(AppRouter.thesis.pathUnderRoot, extra: thesis),
        leading: HaloAvatar(publisher.photoUrl),
        title: Text(
          publisher.name.toStringParseNull(),
          overflow: TextOverflow.ellipsis,
          style: context.theme.textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Designation
            Text.rich(
              TextSpan(
                text: 'Designation: ',
                children: [
                  TextSpan(
                    text: publisher.designation.toStringParseNull(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              style: context.theme.textTheme.titleSmall?.copyWith(
                color: context.theme.badgeTheme.backgroundColor,
              ),
            ),
            // Department
            Text.rich(
              TextSpan(
                text: 'Department: ',
                children: [
                  TextSpan(
                    text: publisher.department.toStringParseNull(),
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
      ),
    );
  }
}

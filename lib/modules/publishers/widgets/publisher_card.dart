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
          style: context.theme.textTheme.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Designation: ',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.badgeTheme.backgroundColor,
                ),
                children: [
                  TextSpan(
                    text: publisher.designation,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Department: ',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.badgeTheme.backgroundColor,
                ),
                children: [
                  TextSpan(
                    text: publisher.department,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: const Column(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:su_research_and_thesis_book/theme/theme.dart';
import 'package:su_research_and_thesis_book/utils/extensions.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({
    required this.label,
    this.count,
    super.key,
    this.padding,
    this.largeSize,
  });

  final String label;
  final int? count;
  final EdgeInsetsGeometry? padding;
  final double? largeSize;

  @override
  Widget build(BuildContext context) {
    return Badge(
      padding: padding,
      largeSize: largeSize,
      label: Text.rich(
        TextSpan(
          text: '$label: ',
          style: context.theme.textTheme.labelSmall,
          children: [
            TextSpan(
              text: count.toStringParseNull(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({
    required this.label,
    required this.count,
    super.key,
    this.padding,
    this.largeSize,
  });

  final String label;
  final int count;
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
          children: [
            TextSpan(
              text: count.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

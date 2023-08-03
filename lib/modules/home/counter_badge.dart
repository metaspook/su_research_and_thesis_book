import 'package:flutter/material.dart';

class CounterBadge extends StatelessWidget {
  const CounterBadge({required this.label, required this.count, super.key});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Badge(
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

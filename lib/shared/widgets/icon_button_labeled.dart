import 'package:flutter/material.dart';
import 'package:su_thesis_book/utils/utils.dart';

class IconButtonLabeled extends StatelessWidget {
  const IconButtonLabeled(this.record, {super.key, this.color, this.size});
  final IconButtonRecord record;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: record.onPressed,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(record.icon, color: color, size: size),
          Text(
            record.label,
            style: TextStyle(fontSize: size == null ? null : size! / 2.4),
          ),
        ],
      ),
    );
  }
}

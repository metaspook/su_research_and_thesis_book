import 'package:flutter/material.dart';

class IconButtonLabeled extends StatelessWidget {
  const IconButtonLabeled(this.record, {super.key});
  final ({IconData icon, String label, void Function()? onPressed}) record;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: record.onPressed,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [Icon(record.icon), Text(record.label)],
      ),
    );
  }
}

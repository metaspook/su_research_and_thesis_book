import 'package:flutter/material.dart';

class OfflineButton extends StatelessWidget {
  const OfflineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.wifi_off_outlined),
      label: const Text('Offline!'),
      onPressed: null,
    );
  }
}

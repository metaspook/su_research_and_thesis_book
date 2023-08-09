import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const TextField(decoration: InputDecoration(hintText: 'email...')),
        const TextField(decoration: InputDecoration(hintText: 'password...')),
        // Proceed button
        Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(onPressed: () {}, child: const Text('Proceed')),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            label: Text('Email'),
            border: border,
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(label: Text('Password'), border: border),
        ),
        const SizedBox(height: 30),

        // Proceed button
        ElevatedButton(onPressed: () {}, child: const Text('Proceed')),
      ],
    );
  }
}

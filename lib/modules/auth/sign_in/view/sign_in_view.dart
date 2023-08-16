import 'package:flutter/material.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/theme/theme.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            label: Text('Email'),
            border: AppThemes.outlineInputBorder,
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            label: Text('Password'),
            border: AppThemes.outlineInputBorder,
          ),
        ),
        const SizedBox(height: 30),

        // Proceed button
        ElevatedButton.icon(
          icon: const Icon(Icons.forward_rounded),
          label: const Text('Proceed'),
          onPressed: () => context.go(AppRouter.home.path),
        ),
      ],
    );
  }
}

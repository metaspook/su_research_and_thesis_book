import 'package:flutter/material.dart';
import 'package:su_thesis_book/router/router.dart';
import 'package:su_thesis_book/theme/theme.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // TextEditingControllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // FocusNodes
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TextEditingControllers
    _emailController.dispose();
    _passwordController.dispose();
    // FocusNodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

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

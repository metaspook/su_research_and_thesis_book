import 'package:flutter/material.dart';
import 'package:su_thesis_book/modules/modules.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Authentication 🔐'),
          // centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sign in'),
              Tab(text: 'Sign up'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [SignInView(), SignUpView()],
        ),
      ),
    );
  }
}

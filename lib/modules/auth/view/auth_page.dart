import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign in'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sign in'),
              Tab(text: 'Sign up'),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: const [
            TextField(decoration: InputDecoration(hintText: 'email...')),
            TextField(decoration: InputDecoration(hintText: 'password...')),
          ],
        ),
      ),
    );
  }
}

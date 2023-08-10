import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(
          onChanged: (value) => bloc.add(SignUpEdited(email: value)),
          decoration: const InputDecoration(hintText: 'name...'),
        ),
        const TextField(decoration: InputDecoration(hintText: 'email...')),
        const TextField(decoration: InputDecoration(hintText: 'password...')),
        const TextField(decoration: InputDecoration(hintText: 'phone...')),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 200, width: 225, child: Card()),
            Column(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Gallery')),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: () {}, child: const Text('Camera')),
              ],
            )
          ],
        ),
        const SizedBox(height: 30),
        // Proceed button
        ElevatedButton(onPressed: () {}, child: const Text('Proceed')),
      ],
    );
  }
}

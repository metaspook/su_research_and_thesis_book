import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/gen/assets.gen.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef SignUpBlocSelector<T> = BlocSelector<SignUpBloc, SignUpState, T>;

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
            // Image Card
            SizedBox(
              height: 200,
              width: 225,
              child: SignUpBlocSelector<String?>(
                selector: (state) => state.imagePath,
                builder: (context, imagePath) {
                  return Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppThemes.borderRadius,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: AppThemes.borderRadius,
                        child: imagePath == null
                            ? Assets.images.placeholderUser01
                                .image(fit: BoxFit.cover)
                            : Image.file(File(imagePath)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                // Camera Button
                ElevatedButton(
                  onPressed: () => bloc.add(SignUpCameraImagePicked()),
                  child: const Text('Camera'),
                ),
                const SizedBox(height: 20),
                // Gallery Button
                ElevatedButton(
                  onPressed: () => bloc.add(SignUpGalleryImagePicked()),
                  child: const Text('Gallery'),
                ),
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

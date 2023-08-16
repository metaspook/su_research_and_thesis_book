import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/gen/assets.gen.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
// import 'package:su_thesis_book/modules/auth/auth.dart';
// import 'package:su_thesis_book/shared/shared.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef SignUpBlocSelector<T> = BlocSelector<SignUpBloc, SignUpState, T>;
typedef SignUpBlocListener = BlocListener<SignUpBloc, SignUpState>;

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    final isLoading = context
        .select((SignUpBloc bloc) => bloc.state.status == SignUpStatus.loading);
    return TranslucentLoader(
      enabled: isLoading,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Name
          TextField(
            onChanged: (value) => bloc.add(SignUpEdited(name: value)),
            decoration: const InputDecoration(hintText: 'name...'),
          ),
          // E-mail
          TextField(
            onChanged: (value) => bloc.add(SignUpEdited(email: value)),
            decoration: const InputDecoration(hintText: 'email...'),
          ),
          // Password
          TextField(
            onChanged: (value) => bloc.add(SignUpEdited(password: value)),
            decoration: const InputDecoration(hintText: 'password...'),
          ),
          // Phone
          TextField(
            onChanged: (value) => bloc.add(SignUpEdited(phone: value)),
            decoration: const InputDecoration(hintText: 'phone...'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image Card
              SizedBox(
                height: 200,
                width: 225,
                child: SignUpBlocSelector<String>(
                  selector: (state) => state.croppedImagePath,
                  builder: (context, croppedImagePath) {
                    return Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppThemes.borderRadius,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: AppThemes.borderRadius,
                          child: croppedImagePath.isEmpty
                              ? Assets.images.placeholderUser01
                                  .image(fit: BoxFit.cover)
                              : Image.file(File(croppedImagePath)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SignUpBlocListener(
                listenWhen: (previous, current) =>
                    previous.pickedImagePath != current.pickedImagePath,
                listener: (context, state) async {
                  final croppedImagePath =
                      await context.croppedImagePath(state.pickedImagePath);
                  bloc.add(SignUpImageCropped(croppedImagePath));
                },
                child: Column(
                  children: [
                    // Camera Button
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt_rounded),
                      label: const Text('Camera'),
                      onPressed: () =>
                          bloc.add(const SignUpImagePicked(ImageSource.camera)),
                    ),
                    const SizedBox(height: 20),
                    // Gallery Button
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library_rounded),
                      label: const Text('Gallery'),
                      onPressed: () => bloc.add(
                        const SignUpImagePicked(ImageSource.gallery),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          // Proceed button

          SignUpBlocListener(
            listenWhen: (previous, current) =>
                // previous.statusMsg != current.statusMsg,
                current.status == SignUpStatus.success ||
                current.status == SignUpStatus.failure,
            listener: (context, state) {
              final snackBar = SnackBar(
                backgroundColor: context.theme.snackBarTheme.backgroundColor
                    ?.withOpacity(.25),
                behavior: SnackBarBehavior.floating,
                content: Text(state.statusMsg),
              );
              context.scaffoldMessenger.showSnackBar(snackBar);
            },
            child: ElevatedButton.icon(
              icon: const Icon(Icons.forward_rounded),
              label: const Text('Proceed'),
              onPressed: () => bloc.add(const SignUpProceeded()),
            ),
          ),
        ],
      ),
    );
  }
}

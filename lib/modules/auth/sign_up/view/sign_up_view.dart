import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/gen/assets.gen.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef SignUpBlocSelector<T> = BlocSelector<SignUpBloc, SignUpState, T>;
typedef SignUpBlocListener = BlocListener<SignUpBloc, SignUpState>;

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _signUpFormKey = GlobalKey<FormState>();
  // TextEditingControllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  // FocusNodes
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  @override
  void dispose() {
    // TextEditingControllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    // FocusNodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    const nameValidator = Validator2([LeadingOrTrailingSpace()]);
    final isLoading = context
        .select((SignUpBloc bloc) => bloc.state.status == SignUpStatus.loading);
    return TranslucentLoader(
      enabled: isLoading,
      child: Form(
        key: _signUpFormKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Name
            TextFormField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              validator: nameValidator.call,
              // validator: Validator.name,
              onFieldSubmitted: _emailFocusNode.onSubmitted,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'name...',
              ),
              onChanged: (value) => bloc.add(SignUpEdited(name: value)),
            ),
            // E-mail
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              validator: Validator.email,
              onFieldSubmitted: _passwordFocusNode.onSubmitted,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'email...'),
              onChanged: (value) => bloc.add(SignUpEdited(email: value)),
            ),
            // Password
            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              validator: Validator.password,
              onFieldSubmitted: _phoneFocusNode.onSubmitted,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(hintText: 'password...'),
              onChanged: (value) => bloc.add(SignUpEdited(password: value)),
            ),
            // Phone
            TextFormField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              validator: Validator.phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: 'phone...'),
              onChanged: (value) => bloc.add(SignUpEdited(phone: value)),
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
                        onPressed: () => bloc
                            .add(const SignUpImagePicked(ImageSource.camera)),
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
                ),
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
                onPressed: () {
                  final valid =
                      _signUpFormKey.currentState?.validate() ?? false;
                  if (valid) {
                    bloc.add(const SignUpProceeded());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

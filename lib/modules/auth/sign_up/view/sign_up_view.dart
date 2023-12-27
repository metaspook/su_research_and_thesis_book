import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropicker/image_cropicker.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/gen/assets.gen.dart';
import 'package:su_thesis_book/modules/auth/auth.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

typedef SignUpBlocSelector<T> = BlocSelector<SignUpBloc, SignUpState, T>;

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final ImageCropicker imageCropicker;
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
  void initState() {
    DesignationRepo().designations.then(print);
    super.initState();
    imageCropicker = ImageCropicker(context);
    // Restore form state.
    _nameController.text = context.read<SignUpBloc>().state.name;
    _emailController.text = context.read<SignUpBloc>().state.email;
    _passwordController.text = context.read<SignUpBloc>().state.password;
    _phoneController.text = context.read<SignUpBloc>().state.phone;
  }

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
    final isLoading =
        context.select((SignUpBloc cubit) => cubit.state.status.isLoading);
    final departments =
        context.select((DepartmentsCubit cubit) => cubit.state.departments);
    final designations =
        context.select((DesignationsCubit cubit) => cubit.state.designations);
    final viewIsLoading =
        departments == null || designations == null || isLoading;

    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpState>(
          listenWhen: (previous, current) =>
              previous.statusMsg != current.statusMsg,
          listener: (context, state) {
            final snackBar = SnackBar(content: Text(state.statusMsg!));
            context.scaffoldMessenger.showSnackBar(snackBar);
          },
        ),
        DesignationsBlocListener(
          listenWhen: (previous, current) => current.hasMessage,
          listener: (context, state) {
            final snackBar = SnackBar(content: Text(state.statusMsg!));
            context.scaffoldMessenger.showSnackBar(snackBar);
          },
        ),
        DepartmentsBlocListener(
          listenWhen: (previous, current) => current.hasMessage,
          listener: (context, state) {
            final snackBar = SnackBar(content: Text(state.statusMsg!));
            context.scaffoldMessenger.showSnackBar(snackBar);
          },
        ),
      ],
      child: TranslucentLoader(
        enabled: viewIsLoading,
        child: Form(
          key: _signUpFormKey,
          child: ListView(
            padding: AppThemes.viewPadding * 2,
            children: [
              // Name
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                validator: Validator.name,
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
              Builder(
                builder: (context) {
                  final isEmptyPassword = context
                      .select((SignUpBloc bloc) => bloc.state.password.isEmpty);
                  final obscurePassword = context
                      .select((SignUpBloc bloc) => bloc.state.obscurePassword);

                  return TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    validator: Validator.password,
                    onFieldSubmitted: _phoneFocusNode.onSubmitted,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'password...',
                      suffixIcon: IconButton(
                        onPressed: isEmptyPassword
                            ? null
                            : () =>
                                bloc.add(const SignUpObscurePasswordToggled()),
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    onChanged: (value) =>
                        bloc.add(SignUpEdited(password: value)),
                  );
                },
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
              // Designations.
              DropdownButtonFormField<String>(
                isExpanded: true,
                borderRadius: AppThemes.borderRadius,
                hint: const Text('designation...'),
                onChanged: (designation) => bloc.add(
                  SignUpEdited(
                    designationIndex: designation == null
                        ? null
                        : designations?.indexOf(designation),
                  ),
                ),
                items: designations
                    ?.map<DropdownMenuItem<String>>(
                      (designation) => DropdownMenuItem<String>(
                        value: designation,
                        child: Text(designation),
                      ),
                    )
                    .toList(),
              ),
              // Departments
              DropdownButtonFormField<String>(
                isExpanded: true,
                menuMaxHeight: AppThemes.menuMaxHeight,
                borderRadius: AppThemes.borderRadius,
                hint: const Text('department...'),
                onChanged: (department) => bloc.add(
                  SignUpEdited(
                    departmentIndex: department == null
                        ? null
                        : departments?.indexOf(department),
                  ),
                ),
                items: departments
                    ?.map<DropdownMenuItem<String>>(
                      (department) => DropdownMenuItem<String>(
                        value: department,
                        child: Text(department),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: AppThemes.height * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image Card
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppThemes.borderRadius,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: context.mediaQuery.size.longestSide * .225,
                      width: context.mediaQuery.size.shortestSide * .45,
                      padding: const EdgeInsets.all(8),
                      child: SignUpBlocSelector<String>(
                        selector: (state) => state.photoPath,
                        builder: (context, photoPath) {
                          return ClipRRect(
                            borderRadius: AppThemes.borderRadius,
                            child: photoPath.isEmpty
                                ? Assets.images.placeholderUser01
                                    .image(fit: BoxFit.cover)
                                : Image.file(
                                    File(photoPath),
                                    fit: BoxFit.cover,
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: AppThemes.height * 4),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Camera Button
                        ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt_rounded),
                          label: const Text('Camera'),
                          onPressed: () async {
                            final photoPath =
                                await imageCropicker.path(ImageSource.camera);
                            final statusMsg = imageCropicker.statusMsg;
                            bloc.add(
                              SignUpPhotoPicked(
                                photoPath,
                                statusMsg: statusMsg,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: AppThemes.height * 4),
                        // Gallery Button
                        ElevatedButton.icon(
                          icon: const Icon(Icons.photo_library_rounded),
                          label: const Text('Gallery'),
                          onPressed: () async {
                            final photoPath =
                                await imageCropicker.path(ImageSource.gallery);
                            final statusMsg = imageCropicker.statusMsg;
                            bloc.add(
                              SignUpPhotoPicked(
                                photoPath,
                                statusMsg: statusMsg,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppThemes.height * 4),
              // Proceed button
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  final enabled = state.name.isNotEmpty ||
                      state.email.isNotEmpty ||
                      state.phone.isNotEmpty ||
                      state.password.isNotEmpty ||
                      state.photoPath.isNotEmpty;
                  return ElevatedButton.icon(
                    icon: const Icon(Icons.forward_rounded),
                    label: const Text('Proceed'),
                    onPressed: enabled
                        ? () {
                            final valid =
                                _signUpFormKey.currentState?.validate() ??
                                    false;
                            if (valid) bloc.add(const SignUpProceeded());
                          }
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

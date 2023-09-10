import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropicker/image_cropicker.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ProfileUpdateView extends StatefulWidget {
  const ProfileUpdateView({super.key});

  @override
  State<ProfileUpdateView> createState() => _ProfileUpdateViewState();
}

class _ProfileUpdateViewState extends State<ProfileUpdateView> {
  late final ImageCropicker imageCropicker;
  final _profileUpdateFormKey = GlobalKey<FormState>();
  // TextEditingControllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  // FocusNodes
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    imageCropicker = ImageCropicker(context);
  }

  @override
  void dispose() {
    // TextEditingControllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    // FocusNodes
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileUpdateBloc>();
    final cubit = context.read<ProfileCubit>();
    const height = 30.0;
    const width = height / 2;
    // Set the hint text.
    final hintTextName = context.read<AppCubit>().state.user.name ?? 'N/A';
    final hintTextEmail = context.read<AppCubit>().state.user.email ?? 'N/A';
    final hintTextPhone = context.read<AppCubit>().state.user.phone ?? 'N/A';

    return Form(
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: width,
          vertical: height,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profile photo
              ProfileUpdateBlocSelector<String>(
                selector: (state) => state.photoPath,
                builder: (context, photoPath) {
                  return HaloAvatar.local(path: photoPath, size: 4);
                },
              ),
              Column(
                children: [
                  // Camera Button
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                    ),
                    label: const Text('Camera'),
                    onPressed: () async {
                      final photoPath =
                          await imageCropicker.path(ImageSource.camera);
                      final statusMsg = imageCropicker.statusMsg;
                      bloc.add(
                        ProfileUpdatePhotoPicked(
                          photoPath,
                          statusMsg: statusMsg,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Gallery Button
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.photo_library_rounded,
                    ),
                    label: const Text('Gallery'),
                    onPressed: () async {
                      final photoPath =
                          await imageCropicker.path(ImageSource.gallery);
                      final statusMsg = imageCropicker.statusMsg;
                      bloc.add(
                        ProfileUpdatePhotoPicked(
                          photoPath,
                          statusMsg: statusMsg,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: height),
          Form(
            key: _profileUpdateFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              child: Column(
                children: [
                  // Name
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    onFieldSubmitted: _emailFocusNode.onSubmitted,
                    validator: (value) =>
                        Validator.name(value, required: false),
                    onChanged: (value) =>
                        bloc.add(ProfileUpdateEdited(name: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: InputDecoration(
                      // filled: true,
                      hintText: hintTextName,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const Text('Name'),
                    ),
                  ),
                  // Email
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: _phoneFocusNode.onSubmitted,
                    validator: (value) =>
                        Validator.email(value, required: false),
                    onChanged: (value) =>
                        bloc.add(ProfileUpdateEdited(email: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: InputDecoration(
                      // filled: true,
                      hintText: hintTextEmail,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const Text('E-mail'),
                    ),
                  ),
                  // Phone
                  TextFormField(
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    onFieldSubmitted: _passwordFocusNode.onSubmitted,
                    validator: (value) =>
                        Validator.phone(value, required: false),
                    onChanged: (value) =>
                        bloc.add(ProfileUpdateEdited(phone: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: InputDecoration(
                      // filled: true,
                      hintText: hintTextPhone,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const Text('Phone'),
                    ),
                  ),
                  // Password
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    validator: (value) =>
                        Validator.password(value, required: false),
                    onChanged: (value) =>
                        bloc.add(ProfileUpdateEdited(password: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: const InputDecoration(
                      // filled: true,
                      label: Text('New Password'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: height - 6),
          ProfileBlocListener(
            listenWhen: (previous, current) =>
                current.status == ProfileUpdateStatus.success ||
                current.status == ProfileUpdateStatus.failure,
            listener: (context, state) {
              final snackBar = SnackBar(
                backgroundColor: context.theme.snackBarTheme.backgroundColor
                    ?.withOpacity(.25),
                behavior: SnackBarBehavior.floating,
                content: Text(state.statusMsg),
              );
              context.scaffoldMessenger.showSnackBar(snackBar);
            },
            child: Row(
              children: [
                // Cancel button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: cubit.toggleEditMode,
                    icon: const Icon(Icons.cancel_rounded),
                    label: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: width),
                Expanded(
                  // Save button
                  child: Builder(
                    builder: (context) {
                      final credential = context
                          .watch<AppCubit>()
                          .state
                          .userCredential
                          ?.credential;
                      final state = context.watch<ProfileUpdateBloc>().state;
                      final enabled = state.name.isNotEmpty ||
                          state.email.isNotEmpty ||
                          state.phone.isNotEmpty ||
                          state.password.isNotEmpty ||
                          state.photoPath.isNotEmpty;

                      return ElevatedButton.icon(
                        onPressed: enabled
                            ? () {
                                final valid = _profileUpdateFormKey.currentState
                                        ?.validate() ??
                                    false;
                                if (valid) {
                                  bloc.add(
                                    ProfileUpdateSaved(
                                      credential: credential,
                                    ),
                                  );
                                }
                              }
                            : null,
                        icon: const Icon(Icons.save_rounded),
                        label: const Text('Save'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

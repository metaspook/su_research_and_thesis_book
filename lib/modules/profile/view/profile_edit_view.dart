import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropicker/image_cropicker.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  late final ImageCropicker imageCropicker;
  final _profileFormKey = GlobalKey<FormState>();
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
    final bloc = context.read<ProfileBloc>();
    const height = 30.0;
    const width = height / 2;
    // Set the hint text.
    final hintTextName = context.read<AppCubit>().state.user.name ?? 'N/A';
    final hintTextEmail = context.read<AppCubit>().state.user.email ?? 'N/A';
    final hintTextPhone = context.read<AppCubit>().state.user.phone ?? 'N/A';

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: width,
        vertical: height,
      ),
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Profile photo
                ProfileBlocSelector<String>(
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
                          ProfilePhotoPicked(
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
                          ProfilePhotoPicked(
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
              key: _profileFormKey,
              child: Column(
                children: [
                  // Name
                  TextFormField(
                    controller: _nameController,
                    validator: (value) =>
                        Validator.name(value, required: false),
                    onChanged: (value) => bloc.add(ProfileEdited(name: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: hintTextName,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const Text('Name'),
                    ),
                  ),
                  // Email
                  TextFormField(
                    controller: _emailController,
                    validator: (value) =>
                        Validator.email(value, required: false),
                    onChanged: (value) => bloc.add(ProfileEdited(email: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: hintTextEmail,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const Text('E-mail'),
                    ),
                  ),
                  // Phone
                  TextFormField(
                    controller: _phoneController,
                    validator: (value) =>
                        Validator.phone(value, required: false),
                    onChanged: (value) => bloc.add(ProfileEdited(phone: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: hintTextPhone,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: const Text('Phone'),
                    ),
                  ),
                  // Password
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) =>
                        Validator.password(value, required: false),
                    onChanged: (value) =>
                        bloc.add(ProfileEdited(password: value)),
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      label: Text('New Password'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: height),
        ProfileBlocListener(
          listenWhen: (previous, current) =>
              current.status == ProfileStatus.success ||
              current.status == ProfileStatus.failure,
          listener: (context, state) {
            final snackBar = SnackBar(
              backgroundColor:
                  context.theme.snackBarTheme.backgroundColor?.withOpacity(.25),
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
                  onPressed: () => bloc.add(const ProfileEditModeToggled()),
                  icon: const Icon(Icons.cancel_rounded),
                  label: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: width),
              Expanded(
                // Save button
                // TODO: separete two bloc
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return ElevatedButton.icon(
                      onPressed: state.name.isEmpty ||
                              state.email.isEmpty ||
                              state.phone.isEmpty ||
                              state.password.isEmpty ||
                              state.photoPath.isEmpty
                          ? null
                          : () {
                              final valid =
                                  _profileFormKey.currentState?.validate() ??
                                      false;
                              if (valid) bloc.add(const ProfileEditSaved());
                            },
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
    );
  }
}

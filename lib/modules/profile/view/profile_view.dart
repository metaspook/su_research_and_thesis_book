import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    const height = 30.0;
    const width = height / 2;
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: width,
        vertical: height,
      ),
      children: [
        AppBlocSelector<AppUser?>(
          selector: (state) => state.user,
          builder: (context, user) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HaloAvatar(
                  imagePath: user?.photoUrl,
                  size: 4,
                ),
                const SizedBox(height: height),
                Card(
                  child: Column(
                    children: [
                      _textFormField(
                        context,
                        'Name  : ${user?.name ?? 'N/A'}',
                      ),
                      _textFormField(
                        context,
                        'Role  : ${user?.role ?? 'N/A'}',
                      ),
                      _textFormField(
                        context,
                        'Phone : ${user?.phone ?? 'N/A'}',
                      ),
                      _textFormField(
                        context,
                        'E-mail: ${user?.email ?? 'N/A'}',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: height),
        // Sign Out button
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
              ElevatedButton.icon(
                onPressed: () => bloc.add(const ProfileEditModeToggled()),
                icon: const Icon(Icons.edit_document),
                label: const Text('Edit'),
              ),
              const SizedBox(width: width),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => bloc.add(const ProfileSignedOut()),
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text('Sign Out'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textFormField(BuildContext context, String initialValue) =>
      TextFormField(
        initialValue: initialValue,
        style: context.theme.textTheme.titleLarge
            ?.copyWith(fontFamily: GoogleFonts.ubuntuMono().fontFamily),
        // enabled: false,
        readOnly: true,
        decoration: const InputDecoration(
          filled: true,
        ),
      );
}

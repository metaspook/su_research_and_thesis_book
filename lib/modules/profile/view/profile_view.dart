import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';
import 'package:su_thesis_book/utils/utils.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: font preload
    final cubit = context.read<ProfileCubit>();
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
              children: [
                // Profile photo
                HaloAvatar(
                  url: user?.photoUrl,
                  size: 4,
                ),
                const SizedBox(height: height),
                Column(
                  children: [
                    for (final e in {
                      'Name': user?.name.toStringParseNull(),
                      'E-mail': user?.email.toStringParseNull(),
                      'Phone': user?.phone.toStringParseNull(),
                      'Role': user?.role.toStringParseNull(),
                    }.entries)
                      TextFormField(
                        initialValue: e.value,
                        readOnly: true,
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          fontFamily: GoogleFonts.ubuntuMono().fontFamily,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Text(e.key),
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: height),
        ProfileBlocListener(
          listenWhen: (previous, current) => current.status.hasMessage,
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
              // Edit button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: cubit.toggleEditMode,
                  icon: const Icon(Icons.edit_document),
                  label: const Text('Edit'),
                ),
              ),
              const SizedBox(width: width),
              Expanded(
                // Sign Out button
                child: ElevatedButton.icon(
                  onPressed: cubit.signOut,
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
}

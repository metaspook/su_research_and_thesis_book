import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    // File('d:/lab/projects/su_thesis_book/assets/images/placeholder_user_01.jpg')
    //     .readAsBytes()
    //     .then(print);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
          leading: context.backButton,),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        children: [
          // Assets.images.placeholderUser01.image(fit: BoxFit.cover),
          const HaloAvatar(
            imagePath:
                'https://cdn.icon-icons.com/icons2/2468/PNG/512/user_kids_avatar_user_profile_icon_149314.png',
            size: 4,
          ),
          const SizedBox(height: 30),
          Card(
            child: Column(
              children: [
                _textFormField(context, 'Name  : Raifur Rahman'),
                _textFormField(context, 'Role  : Student'),
                _textFormField(context, 'Phone : +01344886532'),
                _textFormField(context, 'E-mail: example@mail.com'),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              // const AuthRepo().signOut();
              null;
              cubit.signOut();
              // context.go(AppRouter.auth.path);
            },
            icon: const Icon(Icons.logout_outlined),
            label: const Text('Sign Out'),
          ),
        ],
      ),
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

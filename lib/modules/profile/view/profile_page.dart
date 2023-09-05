import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';
import 'package:su_thesis_book/theme/theme.dart';

typedef ProfileBlocSelector<T> = BlocSelector<ProfileCubit, ProfileState, T>;
// typedef ProfileBlocListener = BlocListener<ProfileCubit, ProfileState>;
typedef AppBlocSelector<T> = BlocSelector<AppCubit, AppState, T>;
// typedef AppBlocListener = BlocListener<AppCubit, AppState>;

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
        leading: context.backButton,
      ),
      body: ProfileBlocSelector<bool>(
        selector: (state) => state.status == ProfileStatus.loading,
        builder: (context, isLoading) {
          return TranslucentLoader(
            enabled: isLoading,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              children: [
                // Assets.images.placeholderUser01.image(fit: BoxFit.cover),
                AppBlocSelector<AppUser?>(
                  selector: (state) => state.user,
                  builder: (context, user) {
                    return Column(
                      children: [
                        HaloAvatar(
                          imagePath: user?.photoUrl,
                          size: 4,
                        ),
                        const SizedBox(height: 30),
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
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: cubit.signOut,
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text('Sign Out'),
                ),
              ],
            ),
          );
        },
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

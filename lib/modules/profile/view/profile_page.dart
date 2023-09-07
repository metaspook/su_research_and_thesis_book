import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

typedef ProfileBlocSelector<T> = BlocSelector<ProfileBloc, ProfileState, T>;
typedef ProfileBlocListener = BlocListener<ProfileBloc, ProfileState>;
typedef AppBlocSelector<T> = BlocSelector<AppCubit, AppState, T>;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: ProfileBlocSelector<bool>(
              selector: (state) => state.editMode,
              builder: (context, editMode) {
                return editMode ? const ProfileEditView() : const ProfileView();
              },
            ),
          );
        },
      ),
    );
  }
}

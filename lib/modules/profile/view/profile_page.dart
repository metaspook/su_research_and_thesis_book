import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:su_thesis_book/app/app.dart';
import 'package:su_thesis_book/modules/profile/profile.dart';
import 'package:su_thesis_book/shared/widgets/widgets.dart';

typedef ProfileBlocSelector<T> = BlocSelector<ProfileCubit, ProfileState, T>;
typedef ProfileBlocListener = BlocListener<ProfileCubit, ProfileState>;
typedef AppBlocSelector<T> = BlocSelector<AppCubit, AppState, T>;
typedef ProfileUpdateBlocBuilder
    = BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>;
typedef ProfileUpdateBlocSelector<T>
    = BlocSelector<ProfileUpdateBloc, ProfileUpdateState, T>;
typedef ProfileUpdateBlocListener
    = BlocListener<ProfileUpdateBloc, ProfileUpdateState>;

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
      body: Builder(
        builder: (context) {
          final isLoading = context.select(
                (ProfileCubit cubit) => cubit.state.status.isLoading,
              ) ||
              context.select(
                (ProfileUpdateBloc bloc) => bloc.state.status.isLoading,
              );
          return TranslucentLoader(
            enabled: isLoading,
            child: ProfileBlocSelector<bool>(
              selector: (state) => state.editMode,
              builder: (context, editMode) {
                return editMode
                    ? const ProfileUpdateView()
                    : const ProfileView();
              },
            ),
          );
        },
      ),
    );
  }
}

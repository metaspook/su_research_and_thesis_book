import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_research_and_thesis_book/shared/repositories/repositories.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const ProfileState());

  final AuthRepo _authRepo;

  //-- Define Cubit Functions
  Future<void> toggleEditMode() async {
    emit(state.copyWith(editMode: !state.editMode));
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    //  SignOut user.
    final errorMsg = await _authRepo.signOut();
    if (errorMsg == null) {
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          statusMsg: 'Success! User signed out.',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          statusMsg: errorMsg,
        ),
      );
    }
  }
}

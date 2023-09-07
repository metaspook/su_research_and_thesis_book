import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const ProfileState()) {
    //-- Register Event Handlers
    on<ProfileEdited>(_onEdited);
    on<ProfileObscurePasswordToggled>(_onObscurePasswordToggled);
    on<ProfileEditModeToggled>(_onEditModeToggled);
    on<ProfileEditModeCanceled>(_onEditModeCanceled);
    on<ProfileSignedOut>(_onSignedOut);
  }

  final AuthRepo _authRepo;

  //-- Define Event Handlers
  Future<void> _onEdited(
    ProfileEdited event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        email: event.email,
        password: event.password,
      ),
    );
  }

  Future<void> _onObscurePasswordToggled(
    ProfileObscurePasswordToggled event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onEditModeToggled(
    ProfileEditModeToggled event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.editMode) {
      emit(state.copyWith(status: ProfileStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: ProfileStatus.initial));
    }
    emit(state.copyWith(editMode: !state.editMode));
  }

  Future<void> _onEditModeCanceled(
    ProfileEditModeCanceled event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(editMode: false));
  }

  Future<void> _onSignedOut(
    ProfileSignedOut event,
    Emitter<ProfileState> emit,
  ) async {
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
      emit(state.copyWith(status: ProfileStatus.failure, statusMsg: errorMsg));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required AuthRepo authRepo, required AppUserRepo appUserRepo})
      : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        super(const ProfileState()) {
    //-- Register Event Handlers
    on<ProfileEdited>(_onEdited);
    on<ProfileEditModeToggled>(_onEditModeToggled);
    on<ProfileEditSaved>(_onEditSaved);
    on<ProfileObscurePasswordToggled>(_onObscurePasswordToggled);
    on<ProfilePhotoPicked>(_onPhotoPicked);
    on<ProfileSignedOut>(_onSignedOut);
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;

  //-- Define Event Handlers
  Future<void> _onEdited(
    ProfileEdited event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProfileStatus.editing,
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
      ),
    );
  }

  Future<void> _onEditModeToggled(
    ProfileEditModeToggled event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(editMode: !state.editMode));
  }

  Future<void> _onEditSaved(
    ProfileEditSaved event,
    Emitter<ProfileState> emit,
  ) async {
    final userId = _authRepo.currentUser?.uid;
    if (userId != null) {
      final prevStatus = state.status;
      emit(state.copyWith(status: ProfileStatus.loading));
      final userData = <String, Object?>{};
      // Name
      if (state.name.isNotEmpty) userData.addAll({'name': state.name});
      // Phone
      if (state.phone.isNotEmpty) userData.addAll({'phone': state.phone});
      // Email
      if (state.email.isNotEmpty) {
        // Update email to authentication.
        final errorMsg = await _authRepo.updateEmail(state.email);
        if (errorMsg == null) {
          userData.addAll({'email': state.email});
        } else {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              statusMsg: errorMsg,
            ),
          );
        }
      }
      // Password
      if (state.password.isNotEmpty) {
        // Update password to authentication.
        final errorMsg = await _authRepo.updatePassword(state.password);
        if (errorMsg == null) {
          userData.addAll({'password': state.password});
        } else {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              statusMsg: errorMsg,
            ),
          );
        }
      }
      // Photo
      if (state.photoPath.isNotEmpty) {
        // Upload updated user photo to storage.
        final uploadRecord =
            await _appUserRepo.uploadPhoto(userId, path: state.photoPath);
        final errorMsg = uploadRecord.$1;
        if (errorMsg == null) {
          userData.addAll({'photoUrl': uploadRecord.photoUrl});
        } else {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              statusMsg: errorMsg,
            ),
          );
        }
      }
      // Update user data to DB.
      if (userData.isNotEmpty) {
        final errorMsg = await _appUserRepo.update(userId, value: userData);
        if (errorMsg == null) {
          emit(
            state.copyWith(
              status: ProfileStatus.success,
              statusMsg: 'Success! Profile update.',
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
      } else {
        emit(state.copyWith(status: prevStatus));
      }
    }
  }

  Future<void> _onPhotoPicked(
    ProfilePhotoPicked event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(statusMsg: event.statusMsg, photoPath: event.photoPath),
    );
  }

  Future<void> _onObscurePasswordToggled(
    ProfileObscurePasswordToggled event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
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
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          statusMsg: errorMsg,
        ),
      );
    }
  }
}

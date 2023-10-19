import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'profile_update_event.dart';
part 'profile_update_state.dart';

class ProfileUpdateBloc extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  ProfileUpdateBloc({
    required AuthRepo authRepo,
    required AppUserRepo appUserRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        super(const ProfileUpdateState()) {
    //-- Register Event Handlers
    on<ProfileUpdateEdited>(_onEdited);
    on<ProfileUpdateSaved>(_onSaved);
    on<ProfileUpdateObscurePasswordToggled>(_onObscurePasswordToggled);
    on<ProfileUpdatePhotoPicked>(_onPhotoPicked);
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;

  //-- Define Event Handlers
  Future<void> _onEdited(
    ProfileUpdateEdited event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProfileUpdateStatus.editing,
        name: event.name,
        email: event.email,
        phone: event.phone,
        password: event.password,
      ),
    );
  }

  Future<void> _onSaved(
    ProfileUpdateSaved event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    final userId = _authRepo.currentUser?.uid;
    if (userId != null) {
      final prevStatus = state.status;
      emit(state.copyWith(status: ProfileUpdateStatus.loading));
      final userData = <String, Object?>{};
      // Name
      if (state.name.isNotEmpty) userData.addAll({'name': state.name});
      // Phone
      if (state.phone.isNotEmpty) userData.addAll({'phone': state.phone});
      // Email
      if (state.email.isNotEmpty && event.credential != null) {
        // Update email to authentication.
        final errorMsg = await _authRepo.updateEmail(state.email);
        if (errorMsg == null) {
          userData.addAll({'email': state.email});
        } else {
          errorMsg.doPrint();
          emit(
            state.copyWith(
              status: ProfileUpdateStatus.failure,
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
              status: ProfileUpdateStatus.failure,
              statusMsg: errorMsg,
            ),
          );
        }
      }
      // Photo
      if (state.photoPath.isNotEmpty) {
        // Upload updated user photo to storage.
        final uploadRecord =
            await _appUserRepo.uploadPhoto(state.photoPath, userId: userId);

        if (uploadRecord.errorMsg == null) {
          userData.addAll({'photoUrl': uploadRecord.photoUrl});
        } else {
          emit(
            state.copyWith(
              status: ProfileUpdateStatus.failure,
              statusMsg: uploadRecord.errorMsg,
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
              status: ProfileUpdateStatus.success,
              statusMsg: 'Success! Profile update.',
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ProfileUpdateStatus.failure,
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
    ProfileUpdatePhotoPicked event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(
      state.copyWith(statusMsg: event.statusMsg, photoPath: event.photoPath),
    );
  }

  Future<void> _onObscurePasswordToggled(
    ProfileUpdateObscurePasswordToggled event,
    Emitter<ProfileUpdateState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }
}

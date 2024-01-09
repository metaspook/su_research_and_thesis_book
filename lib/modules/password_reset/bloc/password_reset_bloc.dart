import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const PasswordResetState()) {
    //-- Register Event Handlers
    on<PasswordResetEdited>(_onEdited);
    on<PasswordResetObscureCurrentPasswordToggled>(
      _onObscureCurrentPasswordToggled,
    );
    on<PasswordResetObscureNewPasswordToggled>(_onObscureNewPasswordToggled);
    on<PasswordResetProceeded>(_onProceeded);
  }

  final AuthRepo _authRepo;

  //-- Define Event Handlers
  Future<void> _onEdited(
    PasswordResetEdited event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(
      state.copyWith(
        email: event.email,
        newPassword: event.newPassword,
        currentPassword: event.currentPassword,
      ),
    );
  }

  Future<void> _onObscureCurrentPasswordToggled(
    PasswordResetObscureCurrentPasswordToggled event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(state.copyWith(obscureCurrentPassword: !state.obscureCurrentPassword));
  }

  Future<void> _onObscureNewPasswordToggled(
    PasswordResetObscureNewPasswordToggled event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(state.copyWith(obscureNewPassword: !state.obscureNewPassword));
  }

  Future<void> _onProceeded(
    PasswordResetProceeded event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(state.copyWith(status: PasswordResetStatus.loading));
    final errorMsg = await _authRepo.forgotPassword(state.email);
    if (errorMsg == null) {
      emit(
        state.copyWith(
          status: PasswordResetStatus.success,
          statusMsg: 'Success! User password reset.',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: PasswordResetStatus.failure,
          statusMsg: errorMsg,
        ),
      );
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const PasswordState()) {
    //-- Register Event Handlers
    on<PasswordEdited>(_onEdited);
    on<PasswordObscurePasswordToggled>(_onObscurePasswordToggled);
    on<PasswordProceeded>(_onProceeded);
  }

  final AuthRepo _authRepo;

  //-- Define Event Handlers
  Future<void> _onEdited(
    PasswordEdited event,
    Emitter<PasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        // email: event.email,
        password: event.password,
      ),
    );
  }

  Future<void> _onObscurePasswordToggled(
    PasswordObscurePasswordToggled event,
    Emitter<PasswordState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onProceeded(
    PasswordProceeded event,
    Emitter<PasswordState> emit,
  ) async {
    emit(state.copyWith(status: PasswordStatus.loading));

    //  Password user.
    // final errorMsg =
    //     await _authRepo.signIn(email: state.email, password: state.password);
    // if (errorMsg == null) {
    //   emit(
    //     state.copyWith(
    //       status: PasswordStatus.success,
    //       statusMsg: 'Success! User signed in.',
    //     ),
    //   );
    // } else {
    //   emit(state.copyWith(status: PasswordStatus.failure, statusMsg: errorMsg));
    // }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/extensions.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const SignInState()) {
    //-- Register Event Handlers
    on<SignInEdited>(_onEdited);
    on<SignInObscurePasswordToggled>(_onObscurePasswordToggled);
    on<SignInProceeded>(_onProceeded);
  }

  final AuthRepo _authRepo;

  //-- Define Event Handlers
  Future<void> _onEdited(
    SignInEdited event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(
        email: event.email,
        password: event.password,
      ),
    );
  }

  Future<void> _onObscurePasswordToggled(
    SignInObscurePasswordToggled event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onProceeded(
    SignInProceeded event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: SignInStatus.loading));

    //  SignIn user.
    final errorMsg =
        await _authRepo.signIn(email: state.email, password: state.password);
    if (errorMsg == null) {
      'hello'.doPrint();
      emit(
        state.copyWith(
          status: SignInStatus.success,
          statusMsg: 'Success! User signed in.',
        ),
      );
    } else {
      emit(state.copyWith(status: SignInStatus.failure, statusMsg: errorMsg));
    }
  }
}

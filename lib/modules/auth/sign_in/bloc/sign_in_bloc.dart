import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

export 'package:su_thesis_book/shared/repositories/repositories.dart'
    show ImageSource;

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const SignInState()) {
    // Register Event Handlers
    on<SignInEdited>(_onEdited);
    on<SignInProceeded>(_onProceeded);
  }

  final AuthRepo _authRepo;

  // Define Event Handlers
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

  Future<void> _onProceeded(
    SignInProceeded event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: SignInStatus.loading));
    // await Future.delayed(
    //   const Duration(seconds: 2),
    //   () => emit(
    //     state.copyWith(
    //       status: SignInStatus.success,
    //       statusMsg: 'Success! User signed up.',
    //     ),
    //   ),
    // );
    final firebaseUser =
        (await _authRepo.signIn(email: state.email, password: state.password))
            ?.user;
    if (firebaseUser != null) {
      final user = User(
        id: firebaseUser.uid,
        name: 'N/A',
        email: state.email,
        phone: 'N/A',
        photoUrl: '',
      );
      _authRepo.addUser(user);
      emit(
        state.copyWith(
          status: SignInStatus.success,
          statusMsg: 'Success! User signed up.',
        ),
      );
    }
  }
}

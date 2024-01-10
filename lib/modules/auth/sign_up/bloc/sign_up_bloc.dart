import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_research_and_thesis_book/shared/repositories/repositories.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthRepo authRepo,
    required AppUserRepo appUserRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        super(const SignUpState()) {
    //-- Register Event Handlers
    // on<SignUpStarted>(_onStarted);
    on<SignUpEdited>(_onEdited);
    on<SignUpPhotoPicked>(_onPhotoPicked);
    on<SignUpProceeded>(_onProceeded);
    on<SignUpObscurePasswordToggled>(_onObscurePasswordToggled);
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;

  //-- Define Event Handlers
  // Future<void> _onStarted(
  //   SignUpStarted event,
  //   Emitter<SignUpState> emit,
  // ) async {
  //   emit(state.copyWith(status: SignUpStatus.loading));
  //   event.designations != null || event.departments != null
  //       ? emit(
  //           state.copyWith(
  //             status: SignUpStatus.success,
  //             designations: event.designations,
  //             departments: event.departments,
  //           ),
  //         )
  //       : emit(
  //           state.copyWith(
  //             status: SignUpStatus.failure,
  //             statusMsg: event.errorMsg,
  //           ),
  //         );
  // }

  Future<void> _onEdited(
    SignUpEdited event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SignUpStatus.editing,
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
        designationIndex: event.designationIndex,
        departmentIndex: event.departmentIndex,
      ),
    );
  }

  Future<void> _onPhotoPicked(
    SignUpPhotoPicked event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(photoPath: event.photoPath, statusMsg: event.statusMsg),
    );
  }

  Future<void> _onObscurePasswordToggled(
    SignUpObscurePasswordToggled event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  Future<void> _onProceeded(
    SignUpProceeded event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    //  SignUp user.
    final signUpRecord =
        await _authRepo.signUp(email: state.email, password: state.password);
    final userId = signUpRecord.userId;

    if (userId != null) {
      // Upload user photo to storage.
      final uploadRecord =
          await _appUserRepo.uploadPhoto(state.photoPath, userId: userId);
      if (uploadRecord.errorMsg == null) {
        final userObj = {
          'departmentIndex': state.departmentIndex,
          'designationIndex': state.designationIndex,
          'email': state.email,
          'name': state.name,
          'phone': state.phone,
          'photoUrl': uploadRecord.photoUrl,
        };
        // Create user data in database.
        final errorMsg = await _appUserRepo.create(userId, value: userObj);
        if (errorMsg == null) {
          // Reload authentication after created.
          // _authRepo.currentUser.doPrint('BIG PROBLEM: ');
          //this worked once with _auth.userChanges() but not now.
          // await _authRepo.currentUser?.reload();
          // _authRepo.currentUser.doPrint('BIG PROBLEM: ');
          emit(
            state.copyWith(
              status: SignUpStatus.success,
              statusMsg: 'Success! User signed up.',
            ),
          );
          //NOTE: It's a workaround due to not auto sign-in and route to home.
          final errorMsg = await _authRepo.signIn(
            email: state.email,
            password: state.password,
          );
          if (errorMsg != null) {
            emit(
              state.copyWith(
                status: SignUpStatus.failure,
                statusMsg: errorMsg,
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              status: SignUpStatus.failure,
              statusMsg: errorMsg,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: SignUpStatus.failure,
            statusMsg: uploadRecord.errorMsg,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          statusMsg: signUpRecord.errorMsg,
        ),
      );
    }
  }
}

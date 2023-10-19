import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

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
    on<SignUpEdited>(_onEdited);
    on<SignUpPhotoPicked>(_onPhotoPicked);
    on<SignUpProceeded>(_onProceeded);
    on<SignUpObscurePasswordToggled>(_onObscurePasswordToggled);
    on<SignUpFormLoaded>(_onFormLoaded);
    //-- Initial Event Handlers
    add(const SignUpFormLoaded());
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;

  //-- Define Event Handlers
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
        role: event.role,
        department: event.department,
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

  Future<void> _onFormLoaded(
    SignUpFormLoaded event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    final rolesRecord = await _appUserRepo.roles;
    final departmentsRecord = await _appUserRepo.departments;
    final errorMsg = rolesRecord.errorMsg ?? departmentsRecord.errorMsg;

    if (errorMsg == null) {
      emit(
        state.copyWith(
          status: SignUpStatus.initial,
          roles: rolesRecord.roles,
          departments: departmentsRecord.departments,
        ),
      );
    } else {
      emit(state.copyWith(status: SignUpStatus.failure, statusMsg: errorMsg));
    }
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
        final roleIndex = state.roles.indexOf(state.role);
        final departmentIndex = state.departments.indexOf(state.department);
        final userObj = {
          'name': state.name,
          'email': state.email,
          'roleIndex': roleIndex,
          'departmentIndex': departmentIndex,
          'phone': state.phone,
          'photoUrl': uploadRecord.photoUrl,
        };
        // Create user data in database.
        final errorMsg = await _appUserRepo.create(userId, value: userObj);
        if (errorMsg == null) {
          emit(
            state.copyWith(
              status: SignUpStatus.success,
              statusMsg: 'Success! User signed up.',
            ),
          );
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

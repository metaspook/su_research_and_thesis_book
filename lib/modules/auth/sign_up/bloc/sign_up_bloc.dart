import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

export 'package:su_thesis_book/shared/repositories/repositories.dart'
    show ImageSource;

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthRepo authRepo,
    required AppUserRepo appUserRepo,
    required RoleRepo roleRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        _roleRepo = roleRepo,
        super(const SignUpState()) {
    //-- Register Event Handlers
    on<SignUpEdited>(_onEdited);
    on<SignUpPhotoPicked>(_onPhotoPicked);
    on<SignUpProceeded>(_onProceeded);
    on<SignUpObscurePasswordToggled>(_onObscurePasswordToggled);
    on<SignUpFormLoaded>(_onFormLoaded);
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;
  final RoleRepo _roleRepo;

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
    final rolesRecord = await _roleRepo.roles;
    final errorMsg = rolesRecord.$1;
    if (rolesRecord.roles.isEmpty) {
      emit(state.copyWith(status: SignUpStatus.failure, statusMsg: errorMsg));
    } else {
      emit(
        state.copyWith(roles: rolesRecord.roles, status: SignUpStatus.initial),
      );
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
    final errorMsg = signUpRecord.$1;
    final userId = signUpRecord.user?.uid;
    if (userId != null) {
      //  Create user.
      final roleIndex = state.roles.indexOf(state.role);
      final userObj = {
        'name': state.name,
        'email': state.email,
        'roleIndex': roleIndex,
        'phone': state.phone,
        'photoPath': state.photoPath,
      };
      final errorMsg = await _appUserRepo.create(userId, value: userObj);
      if (errorMsg == null) {
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            statusMsg: 'Success! User signed up.',
          ),
        );
      } else {
        emit(state.copyWith(status: SignUpStatus.failure, statusMsg: errorMsg));
      }
    } else {
      emit(state.copyWith(status: SignUpStatus.failure, statusMsg: errorMsg));
    }
  }
}

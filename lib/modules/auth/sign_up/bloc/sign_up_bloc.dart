import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
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
    // Register Event Handlers
    on<SignUpEdited>(_onEdited);
    on<SignUpPhotoPicked>(_onPhotoPicked);
    on<SignUpProceeded>(_onProceeded);
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;
  final RoleRepo _roleRepo;

  // Define Event Handlers
  Future<void> _onEdited(
    SignUpEdited event,
    Emitter<SignUpState> emit,
  ) async {
    emit(
      state.copyWith(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
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

  Future<void> _onProceeded(
    SignUpProceeded event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: SignUpStatus.loading));

    final user =
        (await _authRepo.signUp(email: state.email, password: state.password))
            ?.user;
    if (user != null) {
      final appUser = AppUser(
        id: user.uid,
        name: state.name,
        email: state.email,
        phone: state.phone,
        photoUrl: state.photoPath,
      );
      final errorMsg = await _appUserRepo.create(appUser.toDatabase());
      if (errorMsg == null) {
        _appUserRepo.addUser(appUser);
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            // statusMsg: 'Success! User signed up.',
          ),
        );
      }
    }
  }
}

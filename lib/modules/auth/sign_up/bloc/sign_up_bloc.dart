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
    required ImageRepo imageRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        _imageRepo = imageRepo,
        super(const SignUpState()) {
    // Register Event Handlers
    on<SignUpEdited>(_onEdited);
    on<SignUpImagePicked>(_onImagePicked);
    on<SignUpImageCropped>(_onImageCropped);
    on<SignUpProceeded>(_onProceeded);
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;
  final ImageRepo _imageRepo;

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

  Future<void> _onImagePicked(
    SignUpImagePicked event,
    Emitter<SignUpState> emit,
  ) async {
    final imagePath = await _imageRepo.pickedImagePath(event.source);
    emit(state.copyWith(pickedImagePath: imagePath));
  }

  Future<void> _onImageCropped(
    SignUpImageCropped event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(croppedImagePath: event.imagePath));
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
        photoUrl: state.croppedImagePath,
      );
      final success = await _appUserRepo.create(appUser.toFirebaseObj());
      if (success) {
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

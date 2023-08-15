import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/extensions/extensions.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

export 'package:su_thesis_book/shared/repositories/repositories.dart'
    show ImageSource;

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required AuthRepo authRepo, required ImageRepo imageRepo})
      : _authRepo = authRepo,
        _imageRepo = imageRepo,
        super(const SignUpState()) {
    // Register Event Handlers
    on<SignUpEdited>(_onEdited);
    on<SignUpImagePicked>(_onImagePicked);
    on<SignUpImageCropped>(_onImageCropped);
    on<SignUpProceeded>(_onProceeded);
  }

  final AuthRepo _authRepo;
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
    state.doPrint();
    emit(state.copyWith(status: SignUpStatus.loading));
    await Future.delayed(
      const Duration(seconds: 2),
      () => emit(state.copyWith(status: SignUpStatus.success)),
    );
    // final userCredential =
    //     await _authRepo.signUp(email: state.email, password: state.password);
    // if (userCredential != null) {
    // emit(state.copyWith(status: SignUpStatus.success));
    // }
  }
}

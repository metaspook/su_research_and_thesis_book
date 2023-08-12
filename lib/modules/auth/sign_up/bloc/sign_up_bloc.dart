import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/extensions/extensions.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

export 'package:su_thesis_book/shared/repositories/repositories.dart'
    show ImageSource;

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required ImageRepo imageRepo})
      : _imageRepo = imageRepo,
        super(const SignUpState()) {
    // Register Event Handlers
    on<SignUpEdited>(_onEdited);
    on<SignUpImagePicked>(_onImagePicked);
    on<SignUpImageCropped>(_onImageCropped);
  }

  final ImageRepo _imageRepo;

  // Define Event Handlers
  Future<void> _onEdited(
    SignUpEdited event,
    Emitter<SignUpState> emit,
  ) async {
    event.doPrint();
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
}

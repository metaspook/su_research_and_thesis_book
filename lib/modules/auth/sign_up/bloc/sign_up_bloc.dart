import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/shared.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required ImageRepo imageRepo})
      : _imageRepo = imageRepo,
        super(const SignUpState()) {
    // Register Event Handlers
    on<SignUpEdited>(_onEdited);
    on<SignUpCameraImagePicked>(_onCameraImagePicked);
    on<SignUpGalleryImagePicked>(_onGalleryImagePicked);
  }

  final ImageRepo _imageRepo;

  // Define Event Handlers
  Future<void> _onEdited(
    SignUpEdited event,
    Emitter<SignUpState> emit,
  ) async {
    event.doPrint();
  }

  Future<void> _onCameraImagePicked(
    SignUpCameraImagePicked event,
    Emitter<SignUpState> emit,
  ) async {
    final imagePath = await _imageRepo.cameraImagePath;
    if (imagePath != null) emit(state.copyWith(imagePath: imagePath));
  }

  Future<void> _onGalleryImagePicked(
    SignUpGalleryImagePicked event,
    Emitter<SignUpState> emit,
  ) async {
    final imagePath = await _imageRepo.galleryImagePath;
    if (imagePath != null) emit(state.copyWith(imagePath: imagePath));
  }
}

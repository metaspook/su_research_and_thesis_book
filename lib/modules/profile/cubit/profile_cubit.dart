import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthRepo authRepo,
    required AppUserRepo appUserRepo,
    required ImageRepo imageRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        _imageRepo = imageRepo,
        super(const ProfileState());

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;
  final ImageRepo _imageRepo;

  void signOut() {
    emit(state.copyWith(status: ProfileStatus.loading));
    _authRepo.signOut();
  }
}

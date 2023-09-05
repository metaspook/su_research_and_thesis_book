import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthRepo authRepo,
    required AppUserRepo appUserRepo,
    required RoleRepo roleRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        _roleRepo = roleRepo,
        super(const ProfileState());

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;
  final RoleRepo _roleRepo;

  Future<void> signOut() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final errorMsg = await _authRepo.signOut();
    if (errorMsg == null) {
      emit(state.copyWith(status: ProfileStatus.failure, statusMsg: errorMsg));
    }
  }
}

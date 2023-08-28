import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required AuthRepo authRepo, required AppUserRepo appUserRepo})
      : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        super(const AppState());

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;

  // AuthUser, DBUser, AppUser

  void initAuth() {
    _authRepo.userStream.listen((user) {
      if (user != null) {
        _appUserRepo.read(user.uid);
      } else {
        _appUserRepo.addUser(null);
      }
    });
    _appUserRepo.appUserStream.listen((appUser) {
      emit(
        state.copyWith(
          status: appUser == null
              ? AppStatus.unauthenticated
              : AppStatus.authenticated,
          user: appUser,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _authRepo.dispose();
    _appUserRepo.dispose();
    return super.close();
  }
}

import 'dart:async';

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
  late final StreamSubscription<User?> _userSubscription;

  // AuthUser, DBUser, AppUser

  void initAuth() {
    // Get authUser.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Get appUser by authUser's id.
        final appUserRecord = await _appUserRepo.read(user.uid);
        final errorMsg = appUserRecord.$1;
        final appUser = appUserRecord.object;
        if (appUser != null) {
          emit(state.copyWith(status: AppStatus.authenticated, user: appUser));
        } else {
          emit(state.copyWith(statusMsg: errorMsg));
          // Sign out authUser because user data not found.
          await _authRepo.signOut();
        }
      } else {
        emit(
          state.copyWith(
            status: AppStatus.unauthenticated,
            user: AppUser.empty,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit({required AuthRepo authRepo, required AppUserRepo appUserRepo})
      : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        super(const AppState()) {
    //-- Initialize Authentication.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Logic after User is authenticated.
        final (errorMsg, appUser) = await _appUserRepo.read(user.uid);
        if (appUser.isNotEmpty) {
          // Logic after User is authenticated and data exists.
          emit(AppState(status: AppStatus.authenticated, user: appUser));
        } else {
          // Logic after User is authenticated but data isn't exists.
          await _authRepo.signOut();
          emit(state.copyWith(statusMsg: errorMsg));
        }
      } else {
        await clear();
        emit(
          state.copyWith(
            status: AppStatus.unauthenticated,
            user: AppUser.empty,
          ),
        );
      }
    });
  }

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;
  late final StreamSubscription<User?> _userSubscription;

  void onGetStarted() {
    emit(state.copyWith(firstLaunch: false));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) => AppState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AppState state) => state.toJson();

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

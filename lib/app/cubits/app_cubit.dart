import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit({required AppUserRepo appUserRepo}) : super(const AppState()) {
    //-- Initialize Authentication.
    _userSubscription = appUserRepo.stream.listen((record) async {
      final (errorMsg, appUser) = record;
      appUser.isAuthenticated
          ? emit(state.copyWith(status: AppStatus.loggedIn, user: appUser))
          : emit(
              state.copyWith(
                status: AppStatus.loggedOut,
                user: AppUser.unauthenticated,
                statusMsg: errorMsg,
              ),
            );
    });
  }

  late final StreamSubscription<(String?, AppUser)> _userSubscription;

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

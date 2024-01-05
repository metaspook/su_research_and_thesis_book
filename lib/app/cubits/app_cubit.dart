import 'dart:async';

import 'package:connectivator/connectivator.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit({required AppUserRepo appUserRepo})
      : _connectivator = Connectivator(),
        super(const AppState()) {
    //-- Initialize Connectivity.
    _connectivitySubscription =
        _connectivator.onConnected().listen((record) async {
      final (statusMsg, online) = record;
      emit(state.copyWith(statusMsg: statusMsg, online: online));
    });
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

  final Connectivator _connectivator;
  late final StreamSubscription<(String?, bool)> _connectivitySubscription;
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
    _connectivitySubscription.cancel();
    return super.close();
  }
}

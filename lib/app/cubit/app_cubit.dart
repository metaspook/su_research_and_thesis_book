import 'dart:async';
import 'dart:convert';

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
      // Check authUser from stream.
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

  final AuthRepo _authRepo;
  final AppUserRepo _appUserRepo;
  late final StreamSubscription<User?> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return json['userCredential'] == null
        ? null
        : state.copyWith(
            userCredential:
                jsonDecode(json['userCredential'] as String) as UserCredential,
          );
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return _authRepo.userCredential == null
        ? null
        : {'userCredential': jsonEncode(_authRepo.userCredential)};
  }
}

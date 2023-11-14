import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit({
    required AuthRepo authRepo,
    required AppUserRepo appUserRepo,
    required DesignationRepo designationRepo,
    required DepartmentRepo departmentRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        _designationRepo = designationRepo,
        _departmentRepo = departmentRepo,
        super(const AppState()) {
    //-- Initialize Designations.
    _designationRepo.designations.then((designationsRecord) {
      emit(state.copyWith(designations: designationsRecord.designations));
    });
    //-- Initialize Departments.
    _departmentRepo.departments.then((departmentsRecord) {
      emit(state.copyWith(departments: departmentsRecord.departments));
    });
    //-- Initialize Authentication.
    _userSubscription = _authRepo.userStream.listen((user) async {
      // Check authUser from stream.
      'Chk here: $user'.doPrint();
      if (user != null) {
        // Get appUser by authUser's id.
        final appUserRecord = await _appUserRepo.read(user.uid);
        appUserRecord.doPrint();
        final errorMsg = appUserRecord.$1;
        final appUser = appUserRecord.object;
        if (appUser.isNotEmpty) {
          // 'user: $user'.doPrint();
          emit(AppState(status: AppStatus.authenticated, user: appUser));
        } else {
          emit(state.copyWith(statusMsg: errorMsg));
          // Sign out authUser because user data not found.
          // await _authRepo.signOut();
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
  final DesignationRepo _designationRepo;
  final DepartmentRepo _departmentRepo;
  late final StreamSubscription<User?> _userSubscription;

  void onGetStarted() {
    emit(state.copyWith(firstLaunch: false));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

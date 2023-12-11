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
    required ThesisRepo thesisRepo,
    required ResearchRepo researchRepo,
  })  : _authRepo = authRepo,
        _appUserRepo = appUserRepo,
        _designationRepo = designationRepo,
        _departmentRepo = departmentRepo,
        _thesisRepo = thesisRepo,
        _researchRepo = researchRepo,
        super(const AppState()) {
    // _connectivitySubscription =

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
      if (user != null) {
        // Logic after User is authenticated.
        final (errorMsg, appUser) = await _appUserRepo.read(user.uid);
        if (appUser.isNotEmpty) {
          // Logic after User is authenticated and data exists.
          emit(AppState(status: AppStatus.authenticated, user: appUser));
          //-- Initialize Theses data subscription.
          _thesesSubscription = _thesisRepo.stream.listen((theses) async {
            if (theses.isNotEmpty) {
              emit(state.copyWith(theses: theses));
            }
          });
          //-- Initialize Researches data subscription.
          _researchesSubscription =
              _researchRepo.stream.listen((researches) async {
            if (researches.isNotEmpty) {
              emit(
                state.copyWith(researches: researches),
              );
            }
          });
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
  final DesignationRepo _designationRepo;
  final DepartmentRepo _departmentRepo;
  late final StreamSubscription<User?> _userSubscription;
  final ThesisRepo _thesisRepo;
  final ResearchRepo _researchRepo;
  late final StreamSubscription<bool> _connectivitySubscription;
  late final StreamSubscription<List<Thesis>> _thesesSubscription;
  late final StreamSubscription<List<Research>> _researchesSubscription;

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
    _thesesSubscription.cancel();
    _researchesSubscription.cancel();
    return super.close();
  }
}

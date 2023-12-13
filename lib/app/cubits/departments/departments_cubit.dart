import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'departments_state.dart';

class DepartmentsCubit extends HydratedCubit<DepartmentsState> {
  DepartmentsCubit({required DepartmentRepo departmentRepo})
      : _departmentRepo = departmentRepo,
        super(const DepartmentsState()) {
    //-- Initialize Departments data.
    _departmentRepo.departments.then((record) {
      final (errorMsg, departments) = record;
      emit(state.copyWith(statusMsg: errorMsg, departments: departments));
    });
  }

  final DepartmentRepo _departmentRepo;

  @override
  DepartmentsState? fromJson(Map<String, dynamic> json) {
    return DepartmentsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DepartmentsState state) {
    return state.toJson();
  }
}

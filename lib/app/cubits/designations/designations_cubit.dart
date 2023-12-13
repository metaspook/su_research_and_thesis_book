import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'designations_state.dart';

class DesignationsCubit extends HydratedCubit<DesignationsState> {
  DesignationsCubit({required DesignationRepo designationRepo})
      : _designationRepo = designationRepo,
        super(const DesignationsState()) {
    //-- Initialize Designations data.
    _designationRepo.designations.then((record) {
      final (errorMsg, designations) = record;
      emit(state.copyWith(statusMsg: errorMsg, designations: designations));
    });
  }

  final DesignationRepo _designationRepo;

  @override
  DesignationsState? fromJson(Map<String, dynamic> json) {
    return DesignationsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DesignationsState state) {
    return state.toJson();
  }
}

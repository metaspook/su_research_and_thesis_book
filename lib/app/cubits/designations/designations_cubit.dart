import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_research_and_thesis_book/shared/repositories/repositories.dart';
import 'package:su_research_and_thesis_book/utils/utils.dart';

part 'designations_state.dart';

class DesignationsCubit extends HydratedCubit<DesignationsState> {
  DesignationsCubit({required DesignationsRepo designationsRepo})
      : _designationRepo = designationsRepo,
        super(const DesignationsState()) {
    //-- Initialize Designations data.
    _designationRepo.designations.then((record) {
      final (errorMsg, designations) = record;
      emit(state.copyWith(statusMsg: errorMsg, designations: designations));
    });
  }

  final DesignationsRepo _designationRepo;

  @override
  DesignationsState? fromJson(Map<String, dynamic> json) {
    return DesignationsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DesignationsState state) {
    return state.toJson();
  }
}

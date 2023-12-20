import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'paper_types_state.dart';

class PaperTypesCubit extends HydratedCubit<PaperTypesState> {
  PaperTypesCubit({required PaperTypeRepo paperTypeRepo})
      : _paperTypeRepo = paperTypeRepo,
        super(const PaperTypesState()) {
    //-- Initialize PaperTypes data.
    _paperTypeRepo.paperTypes.then((record) {
      final (errorMsg, paperTypes) = record;
      emit(state.copyWith(statusMsg: errorMsg, paperTypes: paperTypes));
    });
  }

  final PaperTypeRepo _paperTypeRepo;

  @override
  PaperTypesState? fromJson(Map<String, dynamic> json) {
    return PaperTypesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PaperTypesState state) {
    return state.toJson();
  }
}

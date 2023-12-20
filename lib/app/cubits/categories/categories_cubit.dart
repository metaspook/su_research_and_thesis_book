import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'categories_state.dart';

class CategoriesCubit extends HydratedCubit<CategoriesState> {
  CategoriesCubit({required CategoryRepo categoryRepo})
      : _categoryRepo = categoryRepo,
        super(const CategoriesState()) {
    //--Initialize Categories data.
    _categoryRepo.categories.then((record) {
      final (errorMsg, categories) = record;
      emit(state.copyWith(statusMsg: errorMsg, categories: categories));
    });
  }

  final CategoryRepo _categoryRepo;

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) {
    return CategoriesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoriesState state) {
    return state.toJson();
  }
}

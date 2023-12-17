import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'categories_state.dart';

class CategoriesCubit extends HydratedCubit<CategoriesState> {
  CategoriesCubit({
    required AuthRepo authRepo,
    required CategoryRepo categoryRepo,
  })  : _authRepo = authRepo,
        _categoryRepo = categoryRepo,
        super(const CategoriesState());

  final AuthRepo _authRepo;
  final CategoryRepo _categoryRepo;
  late final StreamSubscription<User?> _userSubscription;

  /// Initialize Categories data.
  void initialize() {
    //-- Initialize Authentication subscription.
    _userSubscription = _authRepo.userStream.listen((user) async {
      if (user != null) {
        // Logic after User is authenticated.
        //-- Initialize Categories data.
        final (errorMsg, categories) = await _categoryRepo.categories;
        emit(state.copyWith(statusMsg: errorMsg, categories: categories));
      } else {
        await clear();
      }
    });
  }

  @override
  CategoriesState? fromJson(Map<String, dynamic> json) {
    return CategoriesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CategoriesState state) {
    return state.toJson();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

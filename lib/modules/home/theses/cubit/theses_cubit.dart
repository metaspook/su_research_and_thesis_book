import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'theses_state.dart';

class ThesesCubit extends Cubit<ThesesState> {
  ThesesCubit({required ThesisRepo thesisRepo})
      : _thesisRepo = thesisRepo,
        super(const ThesesState()) {
    //-- Theses data subscription.
    emit(state.copyWith(status: ThesesStatus.loading));
    _thesesSubscription = _thesisRepo.stream.listen((theses) async {
      if (theses.isNotEmpty) {
        emit(state.copyWith(status: ThesesStatus.success, theses: theses));
      }
    });
  }

  final ThesisRepo _thesisRepo;
  late final StreamSubscription<List<Thesis>> _thesesSubscription;

  @override
  Future<void> close() {
    _thesesSubscription.cancel();
    return super.close();
  }
}

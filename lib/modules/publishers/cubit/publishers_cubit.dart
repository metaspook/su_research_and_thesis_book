import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'publishers_state.dart';

class PublishersCubit extends Cubit<PublishersState> {
  PublishersCubit({
    required List<Thesis>? theses,
    required AppUser appUserRepo,
    required ThesisRepo thesisRepo,
  })  : _appUserRepo = appUserRepo,
        _thesisRepo = thesisRepo,
        super(const PublishersState()) {
    // final publishers = <Publisher>[];

    // if (theses != null && theses.isNotEmpty) {
    //   final publisherIds = theses.map((e) => e.userId);

    //   emit(state.copyWith(status: HomeStatus.success, theses: theses));
    // }
  }

  final AppUser _appUserRepo;
  final ThesisRepo _thesisRepo;
  // late final StreamSubscription<List<Publisher>> _publisherSubscription;

  Future<void> intiPublishers() async {
    // (await _publisherRepo.publisherIds()).doPrint('Publishers: ');
    'Hellooooooooooo'.doPrint();
    _thesisRepo.stream.listen((event) {});
  }
}

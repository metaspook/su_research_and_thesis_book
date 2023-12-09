import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

part 'publishers_state.dart';

class PublishersCubit extends Cubit<PublishersState> {
  PublishersCubit() : super(const PublishersState()) {
    // emit(state.copyWith(status: PublishersStatus.loading));
    // emit(
    //   state.copyWith(
    //     status: PublishersStatus.success,
    //     // publishers: papers.publishers,
    //   ),
    // );
  }
}

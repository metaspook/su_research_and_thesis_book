import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const AppState());

  final AuthRepo _authRepo;

  void initAuth() {
    // _authRepo.userStream.listen((user) {
    //   // if (user != null) {
    //   emit(
    //     state.copyWith(
    //       status: user == null
    //           ? AppStatus.unauthenticated
    //           : AppStatus.authenticated,
    //     ),
    //   );
    //   // }
    // });
  }
}

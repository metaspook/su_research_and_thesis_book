import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'thesis_state.dart';

class ThesisCubit extends Cubit<ThesisState> {
  ThesisCubit({
    required BookmarksRepo bookmarksRepo,
    required ThesesRepo thesesRepo,
    required String thesisId,
  })  : _thesisRepo = thesesRepo,
        _bookmarkRepo = bookmarksRepo,
        super(const ThesisState()) {
    //-- Increment Thesis views.
    // incrementViews(state.thesis);
    emit(state.copyWith(status: ThesisStatus.loading));
    thesesRepo.thesisById(thesisId).then((thesis) {
      thesis == null
          ? emit(state.copyWith(status: ThesisStatus.failure))
          : emit(state.copyWith(status: ThesisStatus.success, thesis: thesis));
    });
  }

  final ThesesRepo _thesisRepo;
  final BookmarksRepo _bookmarkRepo;
  static bool _firstView = true;

  /// Increment Thesis view count.
  /// * Increment only once if `firstView` is `true`.
  Future<void> incrementViews(Thesis thesis, {bool firstView = true}) async {
    if (_firstView == firstView) {
      final value = {'views': (thesis.views ?? 0) + 1};
      final errorMsg = await _thesisRepo.update(thesis.id, value: value);
      if (errorMsg == null) {
        if (_firstView) _firstView = !_firstView;
      } else {
        emit(
          state.copyWith(
            status: ThesisStatus.failure,
            statusMsg: "Couldn't increment Thesis views!",
          ),
        );
      }
    }
  }

  Future<void> onPressedBookmark() async {
    final paper = (type: PaperType.thesis, id: state.thesis!.id);
    final errorMsg = await _bookmarkRepo.addBookmark(paper);

    if (errorMsg == null) {
      emit(
        state.copyWith(
          status: ThesisStatus.success,
          statusMsg: 'Bookmarked successfully!',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ThesisStatus.failure,
          statusMsg: errorMsg,
        ),
      );
    }
  }

  Future<void> onPressedDownload() async {
    // Get Download directory.
    var downloadsDir = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : Directory('/storage/emulated/0/Download');
    if (!downloadsDir.existsSync()) {
      downloadsDir = (await getExternalStorageDirectory())!;
    }
    // Set file to target path.
    final file = File(state.filePath);
    final fileName = file.path.split(Platform.pathSeparator).last;
    final targetPath = '${downloadsDir.path}${Platform.pathSeparator}$fileName';
    // Save the file if not exists.
    if (File(targetPath).existsSync()) {
      emit(
        state.copyWith(
          status: ThesisStatus.failure,
          statusMsg: 'File already exists downloads!',
        ),
      );
    } else {
      await file.copy(targetPath).then((_) {
        emit(
          state.copyWith(
            status: ThesisStatus.success,
            statusMsg: 'File saved in downloads!',
          ),
        );
      });
    }
  }

  Future<void> whenDoneLoading(String filePath) async =>
      emit(state.copyWith(filePath: filePath));
}

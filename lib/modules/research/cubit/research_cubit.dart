import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/shared/repositories/repositories.dart';

part 'research_state.dart';

class ResearchCubit extends Cubit<ResearchState> {
  ResearchCubit({
    required ResearchesRepo researchesRepo,
    required BookmarksRepo bookmarksRepo,
    required String researchId,
  })  : _researchRepo = researchesRepo,
        _bookmarkRepo = bookmarksRepo,
        super(const ResearchState()) {
    //-- Increment Researches views.
    // incrementViews(state.research);
    emit(state.copyWith(status: ResearchStatus.loading));
    researchesRepo.researchById(researchId).then((research) {
      research == null
          ? emit(state.copyWith(status: ResearchStatus.failure))
          : emit(
              state.copyWith(
                status: ResearchStatus.success,
                research: research,
              ),
            );
    });
  }

  final ResearchesRepo _researchRepo;
  final BookmarksRepo _bookmarkRepo;
  static bool _firstView = true;

  /// Increment Research view count.
  /// * Increment only once if `firstView` is `true`.
  Future<void> incrementViews(
    Research research, {
    bool firstView = true,
  }) async {
    if (_firstView == firstView) {
      final value = {'views': (research.views ?? 0) + 1};
      final errorMsg = await _researchRepo.update(research.id, value: value);
      if (errorMsg == null) {
        if (_firstView) _firstView = !_firstView;
      } else {
        emit(
          state.copyWith(
            status: ResearchStatus.failure,
            statusMsg: "Couldn't increment Research views!",
          ),
        );
      }
    }
  }

  Future<void> onPressedBookmark() async {
    final paper = (type: PaperType.research, id: state.research!.id);
    final errorMsg = await _bookmarkRepo.addBookmark(paper);

    if (errorMsg == null) {
      emit(
        state.copyWith(
          status: ResearchStatus.success,
          statusMsg: 'Bookmarked successfully!',
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ResearchStatus.failure,
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
          status: ResearchStatus.failure,
          statusMsg: 'File already exists downloads!',
        ),
      );
    } else {
      await file.copy(targetPath).then((_) {
        emit(
          state.copyWith(
            status: ResearchStatus.success,
            statusMsg: 'File saved in downloads!',
          ),
        );
      });
    }
  }

  Future<void> whenDoneLoading(String filePath) async =>
      emit(state.copyWith(filePath: filePath));
}

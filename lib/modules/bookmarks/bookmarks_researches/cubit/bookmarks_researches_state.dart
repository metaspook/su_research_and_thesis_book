part of 'bookmarks_researches_cubit.dart';

enum BookmarksResearchesStatus {
  initial,
  selecting,
  loading,
  success,
  failure;

  bool get isLoading => this == BookmarksResearchesStatus.loading;
  bool get hasMessage =>
      this == BookmarksResearchesStatus.success ||
      this == BookmarksResearchesStatus.failure;
}

class BookmarksResearchesState extends Equatable {
  const BookmarksResearchesState({
    this.status = BookmarksResearchesStatus.initial,
    this.statusMsg = '',
    this.removeMode = false,
    this.researches,
    this.selectedResearches = const [],
    this.researchBookmarks = const [],
  });

  final BookmarksResearchesStatus status;
  final String statusMsg;
  final bool removeMode;
  final List<Research>? researches;
  final List<Research> selectedResearches;
  final List<Bookmark>? researchBookmarks;

  BookmarksResearchesState copyWith({
    BookmarksResearchesStatus? status,
    String? statusMsg,
    bool? removeMode,
    List<Research>? researches,
    List<Research>? selectedResearches,
    List<Bookmark>? researchBookmarks,
  }) {
    return BookmarksResearchesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      removeMode: removeMode ?? this.removeMode,
      researches: researches ?? this.researches,
      selectedResearches: selectedResearches ?? this.selectedResearches,
      researchBookmarks: researchBookmarks ?? this.researchBookmarks,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMsg,
        removeMode,
        researches,
        selectedResearches,
        researchBookmarks,
      ];
}

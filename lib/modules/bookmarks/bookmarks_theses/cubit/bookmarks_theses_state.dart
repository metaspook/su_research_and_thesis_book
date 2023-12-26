part of 'bookmarks_theses_cubit.dart';

enum BookmarksThesesStatus {
  initial,
  selecting,
  loading,
  success,
  failure;

  bool get isLoading => this == BookmarksThesesStatus.loading;
  bool get hasMessage =>
      this == BookmarksThesesStatus.success ||
      this == BookmarksThesesStatus.failure;
}

class BookmarksThesesState extends Equatable {
  const BookmarksThesesState({
    this.status = BookmarksThesesStatus.initial,
    this.statusMsg = '',
    this.removeMode = false,
    this.theses,
    this.selectedTheses = const [],
    this.thesisBookmarks,
  });

  final BookmarksThesesStatus status;
  final String statusMsg;
  final bool removeMode;
  final List<Thesis>? theses;
  final List<Thesis> selectedTheses;
  final List<Bookmark>? thesisBookmarks;

  BookmarksThesesState copyWith({
    BookmarksThesesStatus? status,
    String? statusMsg,
    bool? removeMode,
    List<Thesis>? theses,
    List<Thesis>? selectedTheses,
    List<Bookmark>? thesisBookmarks,
  }) {
    return BookmarksThesesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      removeMode: removeMode ?? this.removeMode,
      theses: theses ?? this.theses,
      selectedTheses: selectedTheses ?? this.selectedTheses,
      thesisBookmarks: thesisBookmarks ?? this.thesisBookmarks,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMsg,
        removeMode,
        theses,
        selectedTheses,
        thesisBookmarks,
      ];
}

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
    this.thesisIds = const [],
  });

  final BookmarksThesesStatus status;
  final String statusMsg;
  final bool removeMode;
  final List<Thesis>? theses;
  final List<Thesis> selectedTheses;
  final List<String> thesisIds;

  BookmarksThesesState copyWith({
    BookmarksThesesStatus? status,
    String? statusMsg,
    bool? removeMode,
    List<Thesis>? theses,
    List<Thesis>? selectedTheses,
    List<String>? thesisIds,
  }) {
    return BookmarksThesesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      removeMode: removeMode ?? this.removeMode,
      theses: theses ?? this.theses,
      selectedTheses: selectedTheses ?? this.selectedTheses,
      thesisIds: thesisIds ?? this.thesisIds,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMsg,
        removeMode,
        theses,
        selectedTheses,
        thesisIds,
      ];
}

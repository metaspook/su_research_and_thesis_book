part of 'bookmarks_cubit.dart';

enum BookmarksStatus {
  initial,
  selecting,
  loading,
  success,
  failure;

  bool get isLoading => this == BookmarksStatus.loading;
  bool get hasMessage =>
      this == BookmarksStatus.success || this == BookmarksStatus.failure;
}

class BookmarksState extends Equatable {
  const BookmarksState({
    this.status = BookmarksStatus.initial,
    this.statusMsg = '',
    this.removeMode = false,
    this.theses,
    this.selectedTheses = const [],
    this.researchIds = const [],
    this.thesisIds = const [],
  });

  final BookmarksStatus status;
  final String statusMsg;
  final bool removeMode;
  final List<Thesis>? theses;
  final List<Thesis> selectedTheses;
  final List<String> researchIds;
  final List<String> thesisIds;

  BookmarksState copyWith({
    BookmarksStatus? status,
    String? statusMsg,
    bool? removeMode,
    List<Thesis>? theses,
    List<Thesis>? selectedTheses,
    List<String>? researchIds,
    List<String>? thesisIds,
  }) {
    return BookmarksState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      removeMode: removeMode ?? this.removeMode,
      theses: theses ?? this.theses,
      selectedTheses: selectedTheses ?? this.selectedTheses,
      researchIds: researchIds ?? this.researchIds,
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
        researchIds,
        thesisIds,
      ];
}

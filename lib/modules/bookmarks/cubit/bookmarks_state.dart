part of 'bookmarks_cubit.dart';

enum BookmarksStatus {
  initial,
  editing,
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
    this.theses = const [],
    this.selectedTheses = const [],
  });

  final BookmarksStatus status;
  final String statusMsg;
  final bool removeMode;
  final List<Thesis> theses;
  final List<Thesis> selectedTheses;

  BookmarksState copyWith({
    BookmarksStatus? status,
    String? statusMsg,
    bool? removeMode,
    List<Thesis>? theses,
    List<Thesis>? selectedTheses,
  }) {
    return BookmarksState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      removeMode: removeMode ?? this.removeMode,
      theses: theses ?? this.theses,
      selectedTheses: selectedTheses ?? this.selectedTheses,
    );
  }

  @override
  List<Object?> get props =>
      [status, statusMsg, removeMode, theses, selectedTheses];
}

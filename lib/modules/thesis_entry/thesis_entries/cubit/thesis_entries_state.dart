part of 'thesis_entries_cubit.dart';

enum ThesisEntriesStatus {
  initial,
  selecting,
  loading,
  success,
  failure;

  bool get isLoading => this == ThesisEntriesStatus.loading;
}

class ThesisEntriesState extends Equatable {
  const ThesisEntriesState({
    this.status = ThesisEntriesStatus.initial,
    this.statusMsg,
    this.removeMode = false,
    this.selectedTheses = const [],
    this.thesisBookmarks,
  });

  final ThesisEntriesStatus status;
  final String? statusMsg;
  final bool removeMode;
  final List<Thesis> selectedTheses;
  final List<Bookmark>? thesisBookmarks;

  ThesisEntriesState copyWith({
    ThesisEntriesStatus? status,
    String? statusMsg,
    bool? removeMode,
    List<Thesis>? selectedTheses,
    List<Bookmark>? thesisBookmarks,
  }) {
    return ThesisEntriesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      removeMode: removeMode ?? this.removeMode,
      selectedTheses: selectedTheses ?? this.selectedTheses,
      thesisBookmarks: thesisBookmarks ?? this.thesisBookmarks,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMsg,
        removeMode,
        selectedTheses,
        thesisBookmarks,
      ];
}

part of 'research_entries_cubit.dart';

enum ResearchEntriesStatus {
  initial,
  selecting,
  loading,
  success,
  failure;

  bool get isLoading => this == ResearchEntriesStatus.loading;
}

class ResearchEntriesState extends Equatable {
  const ResearchEntriesState({
    this.status = ResearchEntriesStatus.initial,
    this.statusMsg,
    this.removeMode = false,
    this.selectedResearches = const [],
    this.researchBookmarks,
  });

  final ResearchEntriesStatus status;
  final String? statusMsg;
  final bool removeMode;
  final List<Research> selectedResearches;
  final List<Bookmark>? researchBookmarks;

  ResearchEntriesState copyWith({
    ResearchEntriesStatus? status,
    String? statusMsg,
    bool? removeMode,
    List<Research>? selectedResearches,
    List<Bookmark>? researchBookmarks,
  }) {
    return ResearchEntriesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      removeMode: removeMode ?? this.removeMode,
      selectedResearches: selectedResearches ?? this.selectedResearches,
      researchBookmarks: researchBookmarks ?? this.researchBookmarks,
    );
  }

  @override
  List<Object?> get props => [
        status,
        statusMsg,
        removeMode,
        selectedResearches,
        researchBookmarks,
      ];
}

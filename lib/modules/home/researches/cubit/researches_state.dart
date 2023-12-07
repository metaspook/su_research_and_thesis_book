part of 'researches_cubit.dart';

enum ResearchesStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ResearchesStatus.loading;
  bool get hasMessage =>
      this == ResearchesStatus.success || this == ResearchesStatus.failure;
}

class ResearchesState extends Equatable {
  const ResearchesState({
    this.status = ResearchesStatus.initial,
    this.statusMsg = '',
    this.searchMode = false,
    this.search = '',
    this.category = 'All',
    this.categories,
  });

  final ResearchesStatus status;
  final String statusMsg;
  final bool searchMode;
  final String search;
  final String category;
  final List<String>? categories;

  ResearchesState copyWith({
    ResearchesStatus? status,
    String? statusMsg,
    bool? searchMode,
    String? search,
    String? category,
    List<String>? categories,
  }) {
    return ResearchesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      searchMode: searchMode ?? this.searchMode,
      search: search ?? this.search,
      category: category ?? this.category,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props =>
      [status, statusMsg, searchMode, search, category, categories];
}

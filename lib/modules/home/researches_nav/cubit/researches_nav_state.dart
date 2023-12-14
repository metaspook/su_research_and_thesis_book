part of 'home_researches_cubit.dart';

enum ResearchesNavStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ResearchesNavStatus.loading;
  bool get hasMessage =>
      this == ResearchesNavStatus.success ||
      this == ResearchesNavStatus.failure;
}

class ResearchesNavState extends Equatable {
  const ResearchesNavState({
    this.status = ResearchesNavStatus.initial,
    this.statusMsg = '',
    this.searchMode = false,
    this.search = '',
    this.category = 'All',
    this.categories,
  });

  final ResearchesNavStatus status;
  final String statusMsg;
  final bool searchMode;
  final String search;
  final String category;
  final List<String>? categories;

  ResearchesNavState copyWith({
    ResearchesNavStatus? status,
    String? statusMsg,
    bool? searchMode,
    String? search,
    String? category,
    List<String>? categories,
  }) {
    return ResearchesNavState(
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

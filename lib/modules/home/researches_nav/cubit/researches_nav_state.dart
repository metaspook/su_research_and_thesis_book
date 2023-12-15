part of 'researches_nav_cubit.dart';

enum ResearchesNavStatus { initial, editing }

class ResearchesNavState extends Equatable {
  const ResearchesNavState({
    this.status = ResearchesNavStatus.initial,
    this.statusMsg = '',
    this.searchMode = false,
    this.search = '',
    this.category = 'All',
  });

  final ResearchesNavStatus status;
  final String statusMsg;
  final bool searchMode;
  final String search;
  final String category;

  ResearchesNavState copyWith({
    ResearchesNavStatus? status,
    String? statusMsg,
    bool? searchMode,
    String? search,
    String? category,
  }) {
    return ResearchesNavState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      searchMode: searchMode ?? this.searchMode,
      search: search ?? this.search,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, searchMode, search, category];
}

part of 'theses_nav_cubit.dart';

enum ThesesNavStatus {
  initial,
  editing,
  loading,
  success,
  failure;
}

class ThesesNavState extends Equatable {
  const ThesesNavState({
    this.status = ThesesNavStatus.initial,
    this.statusMsg = '',
    this.searchMode = false,
    this.search = '',
    this.department = 'All',
  });

  final ThesesNavStatus status;
  final String statusMsg;
  final bool searchMode;
  final String search;
  final String department;

  ThesesNavState copyWith({
    ThesesNavStatus? status,
    String? statusMsg,
    bool? searchMode,
    String? search,
    String? department,
  }) {
    return ThesesNavState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      searchMode: searchMode ?? this.searchMode,
      search: search ?? this.search,
      department: department ?? this.department,
    );
  }

  @override
  List<Object?> get props =>
      [status, statusMsg, searchMode, search, department];
}

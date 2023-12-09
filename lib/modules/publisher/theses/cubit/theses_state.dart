part of 'theses_cubit.dart';

enum ThesesStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ThesesStatus.loading;
  bool get hasMessage =>
      this == ThesesStatus.success || this == ThesesStatus.failure;
}

class ThesesState extends Equatable {
  const ThesesState({
    this.status = ThesesStatus.initial,
    this.statusMsg = '',
    this.searchMode = false,
    this.search = '',
    this.department = 'All',
    this.departments,
  });

  final ThesesStatus status;
  final String statusMsg;
  final bool searchMode;
  final String search;
  final String department;
  final List<String>? departments;

  ThesesState copyWith({
    ThesesStatus? status,
    String? statusMsg,
    bool? searchMode,
    String? search,
    String? department,
    List<String>? departments,
  }) {
    return ThesesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      searchMode: searchMode ?? this.searchMode,
      search: search ?? this.search,
      department: department ?? this.department,
      departments: departments ?? this.departments,
    );
  }

  @override
  List<Object?> get props =>
      [status, statusMsg, searchMode, search, department, departments];
}

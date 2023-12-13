part of 'theses_cubit.dart';

enum ThesesStatus {
  initial,
  editing,
  loading,
  success,
  failure;
}

class ThesesState extends Equatable {
  const ThesesState({
    this.status = ThesesStatus.initial,
    this.statusMsg = '',
    this.searchMode = false,
    this.search = '',
    this.department = 'All',
  });

  final ThesesStatus status;
  final String statusMsg;
  final bool searchMode;
  final String search;
  final String department;

  ThesesState copyWith({
    ThesesStatus? status,
    String? statusMsg,
    bool? searchMode,
    String? search,
    String? department,
  }) {
    return ThesesState(
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

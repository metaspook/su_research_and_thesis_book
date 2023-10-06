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
  });

  final ThesesStatus status;
  final String statusMsg;
  final bool searchMode;
  final String search;

  ThesesState copyWith({
    ThesesStatus? status,
    String? statusMsg,
    bool? searchMode,
    String? search,
  }) {
    return ThesesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      searchMode: searchMode ?? this.searchMode,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, searchMode, search];
}

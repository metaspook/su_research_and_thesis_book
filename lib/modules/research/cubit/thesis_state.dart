part of 'thesis_cubit.dart';

enum ThesisStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ThesisStatus.loading;
  bool get hasMessage =>
      this == ThesisStatus.success || this == ThesisStatus.failure;
}

class ThesisState extends Equatable {
  const ThesisState({
    required this.thesis,
    this.status = ThesisStatus.initial,
    this.statusMsg = '',
    this.filePath = '',
  });

  final ThesisStatus status;
  final String statusMsg;
  final Thesis thesis;
  final String filePath;

  ThesisState copyWith({
    ThesisStatus? status,
    String? statusMsg,
    Thesis? thesis,
    String? filePath,
  }) {
    return ThesisState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      thesis: thesis ?? this.thesis,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, thesis, filePath];
}

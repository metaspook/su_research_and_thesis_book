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
  });

  final ThesisStatus status;
  final String statusMsg;
  final Thesis thesis;

  ThesisState copyWith({
    ThesisStatus? status,
    String? statusMsg,
    Thesis? thesis,
  }) {
    return ThesisState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      thesis: thesis ?? this.thesis,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, thesis];
}

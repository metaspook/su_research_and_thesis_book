part of 'thesis_entry_cubit.dart';

enum ThesisEntryStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ThesisEntryStatus.loading;
  bool get hasMessage =>
      this == ThesisEntryStatus.success || this == ThesisEntryStatus.failure;
}

final class ThesisEntryState extends Equatable {
  const ThesisEntryState({
    this.status = ThesisEntryStatus.initial,
    this.statusMsg = '',
    this.title = '',
    this.departmentIndex = 0,
    this.description = '',
    this.pdfPath = '',
  });

  final ThesisEntryStatus status;
  final String statusMsg;
  final String title;
  final int departmentIndex;
  final String description;
  final String pdfPath;

  ThesisEntryState copyWith({
    ThesisEntryStatus? status,
    String? statusMsg,
    String? title,
    int? departmentIndex,
    String? description,
    String? pdfPath,
  }) {
    return ThesisEntryState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      title: title ?? this.title,
      departmentIndex: departmentIndex ?? this.departmentIndex,
      description: description ?? this.description,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  List<Object> get props =>
      [status, statusMsg, title, departmentIndex, description, pdfPath];
}

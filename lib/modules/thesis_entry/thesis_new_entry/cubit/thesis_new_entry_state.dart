part of 'thesis_new_entry_cubit.dart';

enum ThesisNewEntryStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ThesisNewEntryStatus.loading;
}

final class ThesisNewEntryState extends Equatable {
  const ThesisNewEntryState({
    this.status = ThesisNewEntryStatus.initial,
    this.statusMsg,
    this.title = '',
    this.departmentIndex = 0,
    this.description = '',
    this.pdfPath = '',
  });

  final ThesisNewEntryStatus status;
  final String? statusMsg;
  final String title;
  final int departmentIndex;
  final String description;
  final String pdfPath;

  ThesisNewEntryState copyWith({
    ThesisNewEntryStatus? status,
    String? statusMsg,
    String? title,
    int? departmentIndex,
    String? description,
    String? pdfPath,
  }) {
    return ThesisNewEntryState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      title: title ?? this.title,
      departmentIndex: departmentIndex ?? this.departmentIndex,
      description: description ?? this.description,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  List<Object?> get props =>
      [status, statusMsg, title, departmentIndex, description, pdfPath];
}

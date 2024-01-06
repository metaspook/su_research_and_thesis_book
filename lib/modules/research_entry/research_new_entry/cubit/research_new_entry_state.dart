part of 'research_new_entry_cubit.dart';

enum ResearchNewEntryStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ResearchNewEntryStatus.loading;
}

final class ResearchNewEntryState extends Equatable {
  const ResearchNewEntryState({
    this.status = ResearchNewEntryStatus.initial,
    this.statusMsg,
    this.title = '',
    this.categoryIndex = 0,
    this.description = '',
    this.pdfPath = '',
  });

  final ResearchNewEntryStatus status;
  final String? statusMsg;
  final String title;
  final int categoryIndex;
  final String description;
  final String pdfPath;

  ResearchNewEntryState copyWith({
    ResearchNewEntryStatus? status,
    String? statusMsg,
    String? title,
    int? categoryIndex,
    String? description,
    String? pdfPath,
  }) {
    return ResearchNewEntryState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      title: title ?? this.title,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      description: description ?? this.description,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  List<Object?> get props =>
      [status, statusMsg, title, categoryIndex, description, pdfPath];
}

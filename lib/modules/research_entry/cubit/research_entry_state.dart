part of 'research_entry_cubit.dart';

enum ResearchEntryStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ResearchEntryStatus.loading;
  bool get hasMessage =>
      this == ResearchEntryStatus.success ||
      this == ResearchEntryStatus.failure;
}

final class ResearchEntryState extends Equatable {
  const ResearchEntryState({
    this.status = ResearchEntryStatus.initial,
    this.statusMsg = '',
    this.title = '',
    this.categoryIndex = 0,
    this.description = '',
    this.pdfPath = '',
  });

  final ResearchEntryStatus status;
  final String statusMsg;
  final String title;
  final int categoryIndex;
  final String description;
  final String pdfPath;

  ResearchEntryState copyWith({
    ResearchEntryStatus? status,
    String? statusMsg,
    String? title,
    int? categoryIndex,
    String? description,
    String? pdfPath,
  }) {
    return ResearchEntryState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      title: title ?? this.title,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      description: description ?? this.description,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  List<Object> get props =>
      [status, statusMsg, title, categoryIndex, description, pdfPath];
}

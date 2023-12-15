part of 'research_entry_cubit.dart';

enum ResearchEntryStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ResearchEntryStatus.loading;
  bool get hasMessage =>
      this == ResearchEntryStatus.success || this == ResearchEntryStatus.failure;
}

final class ResearchEntryState extends Equatable {
  const ResearchEntryState({
    this.status = ResearchEntryStatus.initial,
    this.statusMsg = '',
    this.researchName = '',
    this.pdfPath = '',
  });

  final ResearchEntryStatus status;
  final String statusMsg;
  final String researchName;
  final String pdfPath;

  ResearchEntryState copyWith({
    ResearchEntryStatus? status,
    String? statusMsg,
    String? researchName,
    String? pdfPath,
  }) {
    return ResearchEntryState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      researchName: researchName ?? this.researchName,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  List<Object> get props => [status, statusMsg, researchName, pdfPath];
}

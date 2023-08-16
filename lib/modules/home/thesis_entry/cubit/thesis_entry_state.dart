part of 'thesis_entry_cubit.dart';

enum ThesisEntryStatus { initial, editing, loading, success, failure }

final class ThesisEntryState extends Equatable {
  const ThesisEntryState({
    this.status = ThesisEntryStatus.initial,
    this.statusMsg = '',
    this.thesisName = '',
    this.pdfPath = '',
  });

  final ThesisEntryStatus status;
  final String statusMsg;
  final String thesisName;
  final String pdfPath;

  ThesisEntryState copyWith({
    ThesisEntryStatus? status,
    String? statusMsg,
    String? thesisName,
    String? pdfPath,
  }) {
    return ThesisEntryState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      thesisName: thesisName ?? this.thesisName,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  List<Object> get props => [status, statusMsg, thesisName, pdfPath];
}

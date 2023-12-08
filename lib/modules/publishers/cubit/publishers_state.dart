part of 'publishers_cubit.dart';

enum PublishersStatus {
  initial,
  selecting,
  loading,
  success,
  failure;

  bool get isLoading => this == PublishersStatus.loading;
  bool get hasMessage =>
      this == PublishersStatus.success || this == PublishersStatus.failure;
}

final class PublishersState extends Equatable {
  const PublishersState({
    this.status = PublishersStatus.initial,
    this.statusMsg = '',
    this.theses,
    this.researches,
    this.publishers,
  });

  final PublishersStatus status;
  final String statusMsg;
  final List<Thesis>? theses;
  final List<Research>? researches;
  final List<Publisher>? publishers;

  PublishersState copyWith({
    PublishersStatus? status,
    String? statusMsg,
    List<Thesis>? theses,
    List<Research>? researches,
    List<Publisher>? publishers,
  }) {
    return PublishersState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      theses: theses ?? this.theses,
      researches: researches ?? this.researches,
      publishers: publishers ?? this.publishers,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      theses,
      researches,
      publishers,
    ];
  }
}

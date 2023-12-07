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

class PublishersState extends Equatable {
  const PublishersState({
    this.status = PublishersStatus.initial,
    this.statusMsg = '',
    this.publishers,
  });

  final PublishersStatus status;
  final String statusMsg;
  final List<Publisher>? publishers;

  PublishersState copyWith({
    PublishersStatus? status,
    String? statusMsg,
    List<Publisher>? publishers,
  }) {
    return PublishersState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      publishers: publishers ?? publishers,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, publishers];
}

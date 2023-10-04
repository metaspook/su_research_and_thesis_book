part of 'theses_cubit.dart';

enum ThesesStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == ThesesStatus.loading;
  bool get hasMessage =>
      this == ThesesStatus.success || this == ThesesStatus.failure;
}

class ThesesState extends Equatable {
  const ThesesState({
    this.status = ThesesStatus.initial,
    this.statusMsg = '',
    this.theses,
  });

  final ThesesStatus status;
  final String statusMsg;
  final List<Thesis>? theses;

  ThesesState copyWith({
    ThesesStatus? status,
    String? statusMsg,
    List<Thesis>? theses,
  }) {
    return ThesesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      theses: theses ?? this.theses,
    );
  }

  @override
  List<Object?> get props => [status, statusMsg, theses];
}

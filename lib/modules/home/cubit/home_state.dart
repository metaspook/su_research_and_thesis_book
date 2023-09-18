part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  editing,
  loading,
  success,
  failure;

  bool get isLoading => this == HomeStatus.loading;
  bool get hasMessage =>
      this == HomeStatus.success || this == HomeStatus.failure;
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.statusMsg = '',
    this.theses = const [],
  });

  final HomeStatus status;
  final String statusMsg;
  final List<Thesis> theses;

  HomeState copyWith({
    HomeStatus? status,
    String? statusMsg,
    List<Thesis>? theses,
  }) {
    return HomeState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      theses: theses ?? this.theses,
    );
  }

  @override
  List<Object> get props => [status, statusMsg, theses];
}

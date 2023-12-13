part of 'departments_cubit.dart';

enum DepartmentsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == DepartmentsStatus.loading;
}

class DepartmentsState extends Equatable {
  const DepartmentsState({
    this.status = DepartmentsStatus.initial,
    this.statusMsg,
    this.departments,
  });

  factory DepartmentsState.fromJson(Map<String, dynamic> json) {
    return DepartmentsState(
      departments: [for (final e in json['departments'] as List) e as String],
    );
  }

  final DepartmentsStatus status;
  final String? statusMsg;
  final List<String>? departments;
  bool get hasMessage => statusMsg != null;

  Json toJson() {
    return <String, dynamic>{
      'departments': departments,
    };
  }

  DepartmentsState copyWith({
    DepartmentsStatus? status,
    String? statusMsg,
    List<String>? departments,
  }) {
    return DepartmentsState(
      status: status ?? this.status,
      statusMsg: statusMsg,
      departments: departments ?? this.departments,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      departments,
    ];
  }
}

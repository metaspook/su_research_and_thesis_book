part of 'designations_cubit.dart';

enum DesignationsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == DesignationsStatus.loading;
}

class DesignationsState extends Equatable {
  const DesignationsState({
    this.status = DesignationsStatus.initial,
    this.statusMsg,
    this.designations,
  });

  factory DesignationsState.fromJson(Map<String, dynamic> json) {
    return DesignationsState(
      designations: [for (final e in json['designations'] as List) e as String],
    );
  }

  final DesignationsStatus status;
  final String? statusMsg;
  final List<String>? designations;
  bool get hasMessage => statusMsg != null;

  Json toJson() {
    return <String, dynamic>{
      'designations': designations,
    };
  }

  DesignationsState copyWith({
    DesignationsStatus? status,
    String? statusMsg,
    List<String>? designations,
  }) {
    return DesignationsState(
      status: status ?? this.status,
      statusMsg: statusMsg,
      designations: designations ?? this.designations,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      designations,
    ];
  }
}

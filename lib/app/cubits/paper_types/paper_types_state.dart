part of 'paper_types_cubit.dart';

enum PaperTypesStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == PaperTypesStatus.loading;
}

class PaperTypesState extends Equatable {
  const PaperTypesState({
    this.status = PaperTypesStatus.initial,
    this.statusMsg,
    this.paperTypes,
  });

  factory PaperTypesState.fromJson(Map<String, dynamic> json) {
    return PaperTypesState(
      paperTypes: [for (final e in json['paperTypes'] as List) e as String],
    );
  }

  final PaperTypesStatus status;
  final String? statusMsg;
  final List<String>? paperTypes;
  bool get hasMessage => statusMsg != null;

  Json toJson() {
    return <String, dynamic>{
      'paperTypes': paperTypes,
    };
  }

  PaperTypesState copyWith({
    PaperTypesStatus? status,
    String? statusMsg,
    List<String>? paperTypes,
  }) {
    return PaperTypesState(
      status: status ?? this.status,
      statusMsg: statusMsg,
      paperTypes: paperTypes ?? this.paperTypes,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      paperTypes,
    ];
  }
}

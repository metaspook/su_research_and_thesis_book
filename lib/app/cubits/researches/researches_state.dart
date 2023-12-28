part of 'researches_cubit.dart';

enum ResearchesStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == ResearchesStatus.loading;
}

class ResearchesState extends Equatable {
  const ResearchesState({
    this.status = ResearchesStatus.initial,
    this.statusMsg,
    this.notify = false,
    this.researches,
  });

  factory ResearchesState.fromJson(Map<String, dynamic> json) {
    return ResearchesState(
      researches: [
        for (final e in json['researches'] as List)
          Research.fromJson(e as Json),
      ],
    );
  }

  final ResearchesStatus status;
  final String? statusMsg;
  final bool notify;
  final List<Research>? researches;
  List<Publisher>? get publishers => researches == null
      ? null
      : <Publisher>[
          for (final e in researches!)
            if (e.publisher != null) e.publisher!,
        ].unique;

  Json toJson() {
    return <String, dynamic>{
      'researches': researches?.map<Json>((e) => e.toJson()).toList(),
    };
  }

  ResearchesState copyWith({
    ResearchesStatus? status,
    String? statusMsg,
    bool? notify,
    List<Research>? researches,
  }) {
    return ResearchesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      notify: notify ?? this.notify,
      researches: researches ?? this.researches,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      notify,
      researches,
    ];
  }
}

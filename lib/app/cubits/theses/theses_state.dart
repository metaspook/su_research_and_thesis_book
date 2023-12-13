part of 'theses_cubit.dart';

enum ThesesStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == ThesesStatus.loading;
}

class ThesesState extends Equatable {
  const ThesesState({
    this.status = ThesesStatus.initial,
    this.statusMsg,
    this.theses,
  });

  factory ThesesState.fromJson(Map<String, dynamic> json) {
    return ThesesState(
      theses: [for (final e in json['theses'] as List) e as Thesis],
    );
  }

  final ThesesStatus status;
  final String? statusMsg;
  final List<Thesis>? theses;
  bool get hasMessage => statusMsg != null;
  List<Publisher>? get publishers => theses == null
      ? null
      : <Publisher>[
          for (final e in theses!)
            if (e.publisher != null) e.publisher!,
        ].unique;

  Json toJson() {
    return <String, dynamic>{
      'theses': theses?.map((e) => e.toJson()).toList(),
    };
  }

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
  List<Object?> get props {
    return [
      status,
      statusMsg,
      theses,
    ];
  }
}

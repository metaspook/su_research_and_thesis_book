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
    this.notify = false,
    this.theses,
  });

  factory ThesesState.fromJson(Map<String, dynamic> json) {
    return ThesesState(
      theses: [
        for (final e in json['theses'] as List) Thesis.fromJson(e as Json),
      ],
    );
  }

  final ThesesStatus status;
  final String? statusMsg;
  final bool notify;
  final List<Thesis>? theses;
  List<Thesis>? thesesOfPublisher(String id) =>
      theses?.where((thesis) => thesis.publisher?.id == id).toList();

  List<Publisher>? get publishers => theses == null
      ? null
      : <Publisher>[
          for (final e in theses!)
            if (e.publisher != null) e.publisher!,
        ].unique;

  Json toJson() {
    return <String, dynamic>{
      'theses': theses?.map<Json>((e) => e.toJson()).toList(),
    };
  }

  ThesesState copyWith({
    ThesesStatus? status,
    String? statusMsg,
    bool? notify,
    List<Thesis>? theses,
  }) {
    return ThesesState(
      status: status ?? this.status,
      statusMsg: statusMsg ?? this.statusMsg,
      notify: notify ?? this.notify,
      theses: theses ?? this.theses,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      notify,
      theses,
    ];
  }
}

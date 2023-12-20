part of 'categories_cubit.dart';

enum CategoriesStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == CategoriesStatus.loading;
}

class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.statusMsg,
    this.categories,
  });

  factory CategoriesState.fromJson(Map<String, dynamic> json) {
    return CategoriesState(
      categories: [for (final e in json['categories'] as List) e as String],
    );
  }

  final CategoriesStatus status;
  final String? statusMsg;
  final List<String>? categories;
  bool get hasMessage => statusMsg != null;

  Json toJson() {
    return <String, dynamic>{
      'categories': categories,
    };
  }

  CategoriesState copyWith({
    CategoriesStatus? status,
    String? statusMsg,
    List<String>? categories,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      statusMsg: statusMsg,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      statusMsg,
      categories,
    ];
  }
}

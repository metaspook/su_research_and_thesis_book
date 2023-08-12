import 'package:equatable/equatable.dart';

final class Thesis extends Equatable {
  const Thesis({
    required this.name,
    required this.author,
    required this.createdAt,
  });

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      name: json['name'] as String,
      author: json['author'] as String,
      createdAt: json['createdAt'] as DateTime,
    );
  }

  final String name;
  final String author;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'author': author,
      'createdAt': createdAt,
    };
  }

  Thesis copyWith({
    String? name,
    String? author,
    DateTime? createdAt,
  }) {
    return Thesis(
      name: name ?? this.name,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, author, createdAt];
}

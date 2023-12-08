import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/utils/utils.dart';

class Research extends Equatable {
  const Research({
    required this.id,
    required this.publisher,
    this.createdAt,
    this.title,
    this.views,
    this.fileUrl,
    this.category,
  });

  factory Research.fromJson(Map<String, dynamic> json) {
    return Research(
      id: json['id'] as String,
      publisher: json['publisher'] as Publisher?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      title: json['title'] as String?,
      views: json['views'] as int?,
      fileUrl: json['fileUrl'] as String?,
      category: json['category'] as String?,
    );
  }

  final String id;
  final Publisher? publisher;
  final DateTime? createdAt;
  final String? title;
  final int? views;
  final String? fileUrl;
  final String? category;

  @override
  List<Object?> get props {
    return [
      id,
      publisher,
      createdAt,
      title,
      views,
      fileUrl,
      category,
    ];
  }

  @override
  bool get stringify => true;
}

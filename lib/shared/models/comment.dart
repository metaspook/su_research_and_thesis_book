import 'package:equatable/equatable.dart';
import 'package:su_research_and_thesis_book/shared/models/models.dart';

final class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.userId,
    required this.paper,
    this.author,
    this.authorPhotoUrl,
    this.createdAt,
    this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      paper: Paper.fromJson(json['paper'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      author: json['author'] as String?,
      authorPhotoUrl: json['authorPhotoUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      content: json['content'] as String?,
    );
  }

  final String id;
  final Paper paper;
  final String userId;
  final String? author;
  final String? authorPhotoUrl;
  final DateTime? createdAt;
  final String? content;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'paper': paper.toJson(),
      'userId': userId,
      'author': author,
      'authorPhotoUrl': authorPhotoUrl,
      'createdAt': createdAt?.toString(),
      'content': content,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      paper,
      userId,
      author,
      authorPhotoUrl,
      createdAt,
      content,
    ];
  }
}

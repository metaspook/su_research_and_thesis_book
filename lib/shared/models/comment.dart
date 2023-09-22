import 'package:equatable/equatable.dart';

final class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.userId,
    required this.thesisId,
    this.author,
    this.authorPhotoUrl,
    this.createdAt,
    this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      thesisId: json['thesisId'] as String,
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
  final String thesisId;
  final String userId;
  final String? author;
  final String? authorPhotoUrl;
  final DateTime? createdAt;
  final String? content;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'thesisId': thesisId,
      'userId': userId,
      'author': author,
      'authorPhotoUrl': authorPhotoUrl,
      'createdAt': createdAt?.toString(),
      'content': content,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, thesisId, userId, author, authorPhotoUrl, createdAt, content];
  }
}

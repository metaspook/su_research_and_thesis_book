import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.author,
    required this.profileImagePath,
    required this.content,
    required this.createdAt,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['author'] as String,
      profileImagePath: json['profileImagePath'] as String,
      content: json['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  final String author;
  final String profileImagePath;
  final String content;
  final DateTime createdAt;

  Comment copyWith({
    String? author,
    String? profileImagePath,
    String? content,
    DateTime? createdAt,
  }) {
    return Comment(
      author: author ?? this.author,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'author': author,
      'profileImagePath': profileImagePath,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [author, profileImagePath, content, createdAt];
}

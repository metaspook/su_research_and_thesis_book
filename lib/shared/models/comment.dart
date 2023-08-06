import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.author,
    required this.content,
    required this.createdAt,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['author'] as String,
      content: json['content'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  final String author;
  final String content;
  final DateTime createdAt;

  Comment copyWith({
    String? author,
    String? content,
    DateTime? createdAt,
  }) {
    return Comment(
      author: author ?? this.author,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'author': author,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [author, content, createdAt];
}

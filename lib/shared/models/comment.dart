import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    required this.id,
    required this.userId,
    required this.thesisId,
    required this.body,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      userId: json['userId'] as String,
      thesisId: json['thesisId'] as String,
      body: json['body'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }
  final String id;
  final String userId;
  final String thesisId;
  final String body;
  final DateTime createdAt;

  Comment copyWith({
    String? id,
    String? userId,
    String? thesisId,
    String? body,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      thesisId: thesisId ?? this.thesisId,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'thesisId': thesisId,
      'body': body,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, userId, thesisId, body, createdAt];
  }
}

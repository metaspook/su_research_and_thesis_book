import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart' show Comment;

class Thesis extends Equatable {
  const Thesis({
    required this.comments,
    required this.id,
    required this.userId,
    this.createdAt,
    this.name,
    this.views,
    this.fileUrl,
    this.author,
  });

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      comments: const [],
      // comments: List<Comment>.from(
      //   (json['comments'] as List<Object>).map<Comment>(
      //     (x) => Comment.fromJson(x.toJson()),
      //   ),
      // ),
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      name: json['name'] as String?,
      views: json['views'] as int?,
      fileUrl: json['fileUrl'] as String?,
      author: json['author'] as String?,
    );
  }

  final List<Comment> comments;
  final String id;
  final String userId;
  final DateTime? createdAt;
  final String? name;
  final int? views;
  final String? fileUrl;
  final String? author;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'comments': comments.map((x) => x.toJson()).toList(),
      'id': id,
      'userId': userId,
      'createdAt': createdAt?.toString(),
      'name': name,
      'views': views,
      'fileUrl': fileUrl,
      'author': author,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [comments, id, userId, author, createdAt, name, views, fileUrl];
  }
}

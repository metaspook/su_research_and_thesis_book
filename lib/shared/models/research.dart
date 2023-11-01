import 'package:equatable/equatable.dart';

class Research extends Equatable {
  const Research({
    required this.id,
    required this.userId,
    this.createdAt,
    this.name,
    this.views,
    this.fileUrl,
    this.category,
    this.author,
    this.authorPhotoUrl,
  });

  factory Research.fromJson(Map<String, dynamic> json) {
    return Research(
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      name: json['name'] as String?,
      views: json['views'] as int?,
      fileUrl: json['fileUrl'] as String?,
      category: json['category'] as String?,
      author: json['author'] as String?,
      authorPhotoUrl: json['authorPhotoUrl'] as String?,
    );
  }

  final String id;
  final String userId;
  final DateTime? createdAt;
  final String? name;
  final int? views;
  final String? fileUrl;
  final String? category;
  final String? author;
  final String? authorPhotoUrl;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'createdAt': createdAt?.toString(),
      'name': name,
      'views': views,
      'fileUrl': fileUrl,
      'category': category,
      'author': author,
      'authorPhotoUrl': authorPhotoUrl,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      createdAt,
      name,
      views,
      fileUrl,
      category,
      author,
      authorPhotoUrl,
    ];
  }

  @override
  bool get stringify => true;
}

import 'package:equatable/equatable.dart';

class Thesis extends Equatable {
  const Thesis({
    required this.id,
    required this.userId,
    this.createdAt,
    this.name,
    this.views,
    this.fileUrl,
    this.author,
    this.authorPhotoUrl,
  });

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      name: json['name'] as String?,
      views: json['views'] as int?,
      fileUrl: json['fileUrl'] as String?,
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
      'author': author,
      'authorPhotoUrl': authorPhotoUrl,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      createdAt,
      name,
      views,
      fileUrl,
      author,
      authorPhotoUrl,
    ];
  }
}

import 'package:equatable/equatable.dart';

final class Bookmark extends Equatable {
  const Bookmark({
    required this.id,
    required this.userId,
    required this.paperId,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'] as String,
      userId: json['userId'] as String,
      paperId: json['paperId'] as String,
    );
  }

  final String id;
  final String userId;
  final String paperId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'paperId': paperId,
      'userId': userId,
    };
  }

  @override
  List<Object> get props => [id, userId, paperId];
}

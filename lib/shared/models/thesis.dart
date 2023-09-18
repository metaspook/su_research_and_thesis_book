import 'package:equatable/equatable.dart';

class Thesis extends Equatable {
  const Thesis({
    required this.id,
    required this.name,
    required this.userId,
    required this.fileUrl,
    required this.createdAt,
  });

  factory Thesis.fromJson(Map<String, dynamic> map) {
    return Thesis(
      id: map['id'] as String,
      name: map['name'] as String?,
      userId: map['userId'] as String?,
      fileUrl: map['fileUrl'] as String?,
      createdAt: map['createdAt'] == null
          ? null
          : DateTime.parse(map['createdAt'] as String),
    );
  }

  final String id;
  final String? name;
  final String? userId;
  final String? fileUrl;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userId': userId,
      'fileUrl': fileUrl,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      userId,
      fileUrl,
      createdAt,
    ];
  }
}

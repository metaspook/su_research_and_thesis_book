import 'package:equatable/equatable.dart';

typedef Publisher = ({
  String id,
  String? name,
  String? designation,
  String? department,
  String? photoUrl
});

class Thesis extends Equatable {
  const Thesis({
    required this.id,
    required this.publisher,
    this.createdAt,
    this.title,
    this.views,
    this.fileUrl,
    this.department,
  });

  factory Thesis.fromJson(Map<String, dynamic> json) {
    return Thesis(
      id: json['id'] as String,
      publisher: json['publisher'] as Publisher?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
      title: json['title'] as String?,
      views: json['views'] as int?,
      fileUrl: json['fileUrl'] as String?,
      department: json['department'] as String?,
    );
  }

  final String id;
  final Publisher? publisher;
  final DateTime? createdAt;
  final String? title;
  final int? views;
  final String? fileUrl;
  final String? department;

  // Map<String, dynamic> toJson() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'userId': publisher,
  //     'createdAt': createdAt?.toString(),
  //     'name': title,
  //     'views': views,
  //     'fileUrl': fileUrl,
  //     'department': department,

  //   };
  // }

  @override
  List<Object?> get props {
    return [
      id,
      publisher,
      createdAt,
      title,
      views,
      fileUrl,
      department,
    ];
  }

  @override
  bool get stringify => true;
}

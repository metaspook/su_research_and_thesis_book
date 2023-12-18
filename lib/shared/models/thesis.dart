import 'package:equatable/equatable.dart';
import 'package:su_thesis_book/shared/models/models.dart';
import 'package:su_thesis_book/utils/utils.dart';

final class Thesis extends Equatable {
  const Thesis({
    required this.id,
    required this.publisher,
    this.createdAt,
    this.title,
    this.views,
    this.fileUrl,
    this.department,
    this.description,
  });

  factory Thesis.fromJson(Json json) {
    return Thesis(
      id: json['id']! as String,
      publisher: Publisher.fromJson(json['publisher']! as Json),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt']! as String),
      title: json['title'] as String?,
      views: json['views'] as int?,
      fileUrl: json['fileUrl'] as String?,
      department: json['department'] as String?,
      description: json['description'] as String?,
    );
  }

  final String id;
  final Publisher? publisher;
  final DateTime? createdAt;
  final String? title;
  final int? views;
  final String? fileUrl;
  final String? department;
  final String? description;

  Json toJson() {
    return <String, dynamic>{
      'id': id,
      'publisher': publisher?.toJson(),
      'createdAt': createdAt.toString(),
      'title': title,
      'views': views,
      'fileUrl': fileUrl,
      'department': department,
      'description': description,
    };
  }

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
      description,
    ];
  }
}

// extension PublishersExt on List<Thesis> {
//   List<Publisher> get publishers => <Publisher>[
//         for (final e in this)
//           if (e.publisher != null) e.publisher!,
//       ];
// }

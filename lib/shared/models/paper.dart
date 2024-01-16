import 'package:equatable/equatable.dart';
import 'package:su_research_and_thesis_book/utils/extensions.dart';

enum PaperType {
  research,
  thesis;

  String get title => name.toCapitalize();
}

class Paper extends Equatable {
  const Paper({
    required this.id,
    required this.type,
    this.title,
  });
  factory Paper.fromJson(Map<String, dynamic> map) => Paper(
        id: map['id'] as String,
        title: map['title'] as String?,
        type: PaperType.values.byName(map['type'] as String),
      );

  final String id;
  final String? title;
  final PaperType type;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'type': type.name,
      };

  @override
  List<Object?> get props => [id, title, type];
}

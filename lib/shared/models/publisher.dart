import 'package:equatable/equatable.dart';

final class Publisher extends Equatable {
  const Publisher({
    required this.id,
    this.name,
    this.designation,
    this.department,
    this.photoUrl,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(
      id: json['id'] as String,
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      department: json['department'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  final String id;
  final String? name;
  final String? designation;
  final String? department;
  final String? photoUrl;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'designation': designation,
      'department': department,
      'photoUrl': photoUrl,
    };
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      designation,
      department,
      photoUrl,
    ];
  }
}

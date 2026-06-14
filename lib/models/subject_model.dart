import 'package:uuid/uuid.dart';

class Subject {
  final String id;
  final String semesterId;
  final String name;
  final String courseCode;
  final int creditHours;
  final String instructor;
  final String classroom;
  final String color;
  final DateTime createdAt;

  Subject({
    String? id,
    required this.semesterId,
    required this.name,
    required this.courseCode,
    required this.creditHours,
    required this.instructor,
    required this.classroom,
    this.color = '#6366F1',
    DateTime? createdAt,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'semesterId': semesterId,
        'name': name,
        'courseCode': courseCode,
        'creditHours': creditHours,
        'instructor': instructor,
        'classroom': classroom,
        'color': color,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json['id'],
        semesterId: json['semesterId'],
        name: json['name'],
        courseCode: json['courseCode'],
        creditHours: json['creditHours'],
        instructor: json['instructor'],
        classroom: json['classroom'],
        color: json['color'] ?? '#6366F1',
        createdAt: DateTime.parse(json['createdAt']),
      );
}

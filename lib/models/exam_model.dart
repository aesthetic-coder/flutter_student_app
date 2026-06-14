import 'package:uuid/uuid.dart';

enum ExamType { quiz, midterm, finalExam }

class Exam {
  final String id;
  final String subjectId;
  final String title;
  final ExamType type;
  final DateTime examDate;
  final String startTime;
  final String endTime;
  final String location;
  final List<String> topics;
  final double weightage;
  final double? marksObtained;
  final double? totalMarks;
  final DateTime createdAt;

  Exam({
    String? id,
    required this.subjectId,
    required this.title,
    this.type = ExamType.midterm,
    required this.examDate,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.topics = const [],
    this.weightage = 20.0,
    this.marksObtained,
    this.totalMarks,
    DateTime? createdAt,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'title': title,
        'type': type.toString(),
        'examDate': examDate.toIso8601String(),
        'startTime': startTime,
        'endTime': endTime,
        'location': location,
        'topics': topics,
        'weightage': weightage,
        'marksObtained': marksObtained,
        'totalMarks': totalMarks,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json['id'],
        subjectId: json['subjectId'],
        title: json['title'],
        type: ExamType.values.firstWhere(
          (e) => e.toString() == json['type'],
          orElse: () => ExamType.midterm,
        ),
        examDate: DateTime.parse(json['examDate']),
        startTime: json['startTime'],
        endTime: json['endTime'],
        location: json['location'],
        topics: List<String>.from(json['topics'] ?? []),
        weightage: json['weightage']?.toDouble() ?? 20.0,
        marksObtained: json['marksObtained']?.toDouble(),
        totalMarks: json['totalMarks']?.toDouble(),
        createdAt: DateTime.parse(json['createdAt']),
      );
}

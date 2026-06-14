import 'package:uuid/uuid.dart';

enum AssignmentStatus { pending, inProgress, submitted, overdue }
enum AssignmentPriority { low, medium, high, critical }

class Assignment {
  final String id;
  final String subjectId;
  final String title;
  final String description;
  final DateTime dueDate;
  final AssignmentStatus status;
  final AssignmentPriority priority;
  final double? marks;
  final double? totalMarks;
  final DateTime createdAt;

  Assignment({
    String? id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status = AssignmentStatus.pending,
    this.priority = AssignmentPriority.medium,
    this.marks,
    this.totalMarks,
    DateTime? createdAt,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  bool get isOverdue => status != AssignmentStatus.submitted && DateTime.now().isAfter(dueDate);

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'status': status.toString(),
        'priority': priority.toString(),
        'marks': marks,
        'totalMarks': totalMarks,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json['id'],
        subjectId: json['subjectId'],
        title: json['title'],
        description: json['description'],
        dueDate: DateTime.parse(json['dueDate']),
        status: AssignmentStatus.values.firstWhere(
          (e) => e.toString() == json['status'],
          orElse: () => AssignmentStatus.pending,
        ),
        priority: AssignmentPriority.values.firstWhere(
          (e) => e.toString() == json['priority'],
          orElse: () => AssignmentPriority.medium,
        ),
        marks: json['marks']?.toDouble(),
        totalMarks: json['totalMarks']?.toDouble(),
        createdAt: DateTime.parse(json['createdAt']),
      );
}

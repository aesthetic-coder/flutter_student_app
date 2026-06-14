import 'package:uuid/uuid.dart';

enum AttendanceStatus { present, absent, leave }

class AttendanceRecord {
  final String id;
  final String subjectId;
  final DateTime date;
  final AttendanceStatus status;
  final DateTime createdAt;

  AttendanceRecord({
    String? id,
    required this.subjectId,
    required this.date,
    required this.status,
    DateTime? createdAt,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'date': date.toIso8601String(),
        'status': status.toString(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) => AttendanceRecord(
        id: json['id'],
        subjectId: json['subjectId'],
        date: DateTime.parse(json['date']),
        status: AttendanceStatus.values.firstWhere(
          (e) => e.toString() == json['status'],
          orElse: () => AttendanceStatus.absent,
        ),
        createdAt: DateTime.parse(json['createdAt']),
      );
}

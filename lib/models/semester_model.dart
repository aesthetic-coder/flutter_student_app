import 'package:uuid/uuid.dart';

class Semester {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String themeColor;
  final bool isActive;
  final bool isArchived;
  final DateTime createdAt;

  Semester({
    String? id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.themeColor = '#6366F1',
    this.isActive = false,
    this.isArchived = false,
    DateTime? createdAt,
  })
      : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'themeColor': themeColor,
        'isActive': isActive,
        'isArchived': isArchived,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        id: json['id'],
        name: json['name'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        themeColor: json['themeColor'] ?? '#6366F1',
        isActive: json['isActive'] ?? false,
        isArchived: json['isArchived'] ?? false,
        createdAt: DateTime.parse(json['createdAt']),
      );

  Semester copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? themeColor,
    bool? isActive,
    bool? isArchived,
    DateTime? createdAt,
  }) =>
      Semester(
        id: id ?? this.id,
        name: name ?? this.name,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        themeColor: themeColor ?? this.themeColor,
        isActive: isActive ?? this.isActive,
        isArchived: isArchived ?? this.isArchived,
        createdAt: createdAt ?? this.createdAt,
      );
}
